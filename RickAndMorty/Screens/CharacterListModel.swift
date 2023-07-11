//
//  CharacterListModel.swift
//  RickAndMorty
//

import Foundation

class CharacterListModel: NSObject {
    var caracterList: [CharacterModel]
    
    init(caracterList: [CharacterModel]) {
        self.caracterList = caracterList
    }
    
    init(_ dataModel: CharacterList) {
        self.caracterList = dataModel.results.map({ characterInfo in
            CharacterModel(characterInfo)
        })
    }
}
