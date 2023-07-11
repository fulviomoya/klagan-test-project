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

class CharacterModel: NSObject {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: BasicInformationModel?
    var location: BasicInformationModel?
    var image: String
    
    struct BasicInformationModel {
        let name: String
        let url: String
    }
    
    init(_ character: Character) {
        self.id = character.id
        self.name = character.name
        self.status = character.status
        self.species = character.species
        self.type = character.type
        self.gender = character.gender
        self.origin =  CharacterModel.BasicInformationModel(name: character.origin!.name, url: character.origin!.url)
        self.location = CharacterModel.BasicInformationModel(name: character.location!.name, url: character.location!.url)
        self.image = character.image
    }
}