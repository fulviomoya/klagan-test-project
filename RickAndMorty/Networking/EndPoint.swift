//
//  EndPoint.swift
//  RickAndMorty
//

import Foundation

protocol EndPointProtocol {
    var path: String { get }
}

extension EndPointProtocol {
    func url(withBaseURL baseURL: String, queryItems: [URLQueryItem] = []) -> URL? {
        guard var components = URLComponents(string: baseURL + path) else {
            return nil
        }
        
        components.queryItems = queryItems
        return components.url
    }
}


struct EndPoint: EndPointProtocol {
    var path: String
    
    init(path: String) {
        self.path = path
    }
    
    static var all: EndPoint {
        EndPoint(path: "/character")
    }
}
