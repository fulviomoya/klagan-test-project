//
//  NetworkManager.swift
//  RickAndMorty
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    var baseUrl: String { get }
    
    func request<Request: RequestProtocol>(_ request: Request, handler: @escaping (Result<Request.Response, Error>) -> Void)
    func setup(baseURL: String)
}

// MARK - NetworkManagerProtocol
class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    var baseUrl: String = ""
    var defaultSession: URLSession
    var cancellable: Set<AnyCancellable> = []
    
    private init() {
        self.defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func setup(baseURL: String) {
        self.baseUrl = baseURL
    }
    
    func request<Request>(_ request: Request, handler: @escaping (Result<Request.Response, Error>) -> Void) where Request : RequestProtocol {
        guard let url = request.endpont.url(withBaseURL: self.baseUrl, queryItems: request.queryItems) else {
            preconditionFailure("Invalid URL...")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method?.rawValue
        
        defaultSession.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { // Checking if the status code is 200 - success http code
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Request.Response.self, decoder: JSONDecoder())
            .sink { completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    handler(Result.failure(error))
                }
            } receiveValue: { value in
                handler(Result.success(value))
            }.store(in: &self.cancellable)
    }
    
}

