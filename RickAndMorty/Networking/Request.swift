//
//  Request.swift
//  RickAndMorty
//

import Foundation

protocol RequestProtocol {
    associatedtype Request: Codable
    associatedtype Response: Codable
    
    var endpont: EndPointProtocol { get }
    var method: RequestMethod? { get }
    var queryItems: [URLQueryItem] { get }
}

protocol RequestMethod {
    var rawValue: String { get }
}

public enum HTTPMethod: String, RequestMethod {
    case get = "GET" // Just need this because the app is for reading from api
}

struct HTTPRequest<Request: Codable, Response: Codable>: RequestProtocol {
    var endpont: EndPointProtocol
    var method: RequestMethod?
    var queryItems: [URLQueryItem]
    
    init(endpont: EndPointProtocol, method: RequestMethod? = nil, queryItems: [URLQueryItem] = []) {
        self.endpont = endpont
        self.method = method
        self.queryItems = queryItems
    }
}
