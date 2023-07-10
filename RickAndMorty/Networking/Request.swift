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
    var queryData: Codable { get }
    var responseData: Codable { get }
}

protocol RequestMethod {
    var rawValue: String { get }
}

public enum HTTPMethod: String, RequestMethod {
    case get = "GET" // Just need this because the app is for reading from api
}
