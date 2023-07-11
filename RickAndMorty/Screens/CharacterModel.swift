//
//  CharacterModel.swift
//  RickAndMorty
//

import Foundation
import Combine
import UIKit

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
    
    var thumbnailImagePublisher = CurrentValueSubject<UIImage, Never>(.placeholder)
    private var imageFetchSubscription: AnyCancellable?
    
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
    
    func fetchImage() {
        if let currentSubscription = imageFetchSubscription {
            // If currently has an background running thread process let's cancel the previous one
            currentSubscription.cancel()
        }
        
        guard let imageURL = URL(string: image) else {
            print("Failed to load image... please check")
            return
        }
        
        self.imageFetchSubscription = ImageService.fetchImage(from: imageURL).sink {  [weak self]  receiveCompletion in
            switch receiveCompletion {
            case .finished:
                self?.imageFetchSubscription = nil
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] image in
            self?.thumbnailImagePublisher.send(image)
        }
    }
    
}
