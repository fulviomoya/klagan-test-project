//
//  Character.swift
//  RickAndMorty
//


import Foundation

struct EmptyData: Codable {}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: BasicInformation?
    let location: BasicInformation?
    let image: String
    
    struct BasicInformation: Codable {
        let name: String
        let url: String
    }
}

