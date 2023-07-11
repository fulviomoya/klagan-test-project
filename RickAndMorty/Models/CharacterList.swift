//
//  CharacterList.swift
//  RickAndMorty
//

import Foundation

struct CharacterList: Codable {
    
    let info: ResponseInfo
    let results: [Character]
    
    struct ResponseInfo: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
