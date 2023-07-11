//
//  HomeViewModel.swift
//  RickAndMorty
//

import Foundation
import UIKit
import Combine


protocol HomeViewModelProtocol {
    var thumbnailImagePublisher: CurrentValueSubject<UIImage, Never>  { get }
    
    func fetchCharacters()
    func fetchImage(thumbnailURL url: String)
    func cancel() 
}

class HomeViewModel: HomeViewModelProtocol {
    var characterListPublisher = CurrentValueSubject<[CharacterModel], Never>([])
    private var listSubscription: AnyCancellable?
    private let service: HomeServiceProtocol
    
    var thumbnailImagePublisher = CurrentValueSubject<UIImage, Never>(.placeholder)
    private var imageFetchSubscription: AnyCancellable?
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    func fetchCharacters() {
        if let currentSubscription = listSubscription {
            // If currently has an background running thread process let's cancel the previous one
            currentSubscription.cancel()
        }
        
        self.listSubscription = service.getCharacters()
            .sink(receiveCompletion: { [weak self] receivedCompletion in
                switch receivedCompletion {
                case .finished:
                    print("Request finished")
                    self?.listSubscription = nil
                case .failure(let error):
                    print("Request error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                print("Fetched data successfully")
                self?.characterListPublisher.send(CharacterListModel(response).caracterList)
            })
    }
    
    func fetchImage(thumbnailURL imageUrl: String) {
        print("buscando imagen \(imageUrl)" )
       /* if let currentSubscription = imageFetchSubscription {
            // If currently has an background running thread process let's cancel the previous one
            currentSubscription.cancel()
        }*/
        
        guard let imageURL = URL(string: imageUrl) else {
            print("Failed to load image... please check")
            return
        }
        
        self.imageFetchSubscription = ImageService.fetchImage(from: imageURL).sink {  [weak self]  receiveCompletion in
            switch receiveCompletion {
            case .finished:
               // self?.imageFetchSubscription = nil
                print("Request finished:: images")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] image in
            print("~", terminator: "")
            self?.thumbnailImagePublisher.send(image)
        }
         
    }
    
    deinit {
        self.cancel()
    }
    
    func cancel() {
        listSubscription?.cancel()
    }
}
