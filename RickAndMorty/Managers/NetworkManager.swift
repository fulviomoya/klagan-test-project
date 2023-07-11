//
//  NetworkManager.swift
//  RickAndMorty
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    var baseUrl: String { get }
    
    func request<Request: RequestProtocol>(_ request: Request) -> AnyPublisher<Request.Response, Error>
}

class NetworkManager: NetworkManagerProtocol {
    var baseUrl: String
    var defaultSession: URLSession
    var cancellable: Set<AnyCancellable> = []
    
    init(baseURL: String) {
        self.baseUrl = baseURL
        self.defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func request<Request>(_ request: Request) -> AnyPublisher<Request.Response, Error> where Request : RequestProtocol {
        guard let url = request.endpont.url(withBaseURL: self.baseUrl, queryItems: request.queryItems) else {
            preconditionFailure("Invalid URL...")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method?.rawValue
        
        return defaultSession.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { // Checking if the status code is 200 - success http code
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Request.Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

