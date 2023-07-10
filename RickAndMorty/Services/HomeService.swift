//
//  HomeService.swift
//  RickAndMorty
//

import Foundation

struct HomeService {
    static let getCharacters: HTTPRequest = HTTPRequest<EmptyData, CharacterList>(endpont: EndPoint.all)
}
