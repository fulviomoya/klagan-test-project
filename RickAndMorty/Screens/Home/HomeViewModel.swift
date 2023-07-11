//
//  HomeViewModel.swift
//  RickAndMorty
//

import Foundation
import UIKit
import Combine


protocol HomeViewModelProtocol {
    //var thumbnailImagePublisher: CurrentValueSubject<UIImage, Never>  { get }
    
    func fetchCharacters()
  //  func fetchImage(thumbnailURL url: String)
    func cancel() 
}

class HomeViewModel: HomeViewModelProtocol {
    var characterListPublisher = CurrentValueSubject<[CharacterModel], Never>([])
    private var listSubscription: AnyCancellable?
    private let service: HomeServiceProtocol
    
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
    
   
    deinit {
        self.cancel()
    }
    
    func cancel() {
        listSubscription?.cancel()
    }
}
