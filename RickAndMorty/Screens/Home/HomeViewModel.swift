//
//  HomeViewModel.swift
//  RickAndMorty
//

import Combine

class HomeViewModel {
    var characterList = CurrentValueSubject<[CharacterModel], Never>([])
    private var listSubscription: AnyCancellable?
    private let service: HomeServiceProtocol
    
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    
    func fetchCharacters() {
        if let currentSubscription = listSubscription { // If currently has an background running cancel previous
            currentSubscription.cancel()
        }
        
        self.listSubscription = service.getCharacters()
            .sink(receiveCompletion: { (receivedCompletion) in
                switch receivedCompletion {
                case .finished:
                    print("Request finished")
                    self.listSubscription = nil
                case .failure(let error):
                    print("Request error: \(error)")
                }
            }, receiveValue: { response in
                print("Fetched data successfully")
                self.characterList.send(CharacterListModel(response).caracterList)
            })
    }
    
    deinit {
        self.cancel()
    }
    
    func cancel() {
        listSubscription?.cancel()
    }
}
