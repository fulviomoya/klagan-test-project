//
//  HomeService.swift
//  RickAndMorty
//

import Combine

protocol HomeServiceProtocol {
    var networkManager: NetworkManagerProtocol { get }
    func getCharacters() -> AnyPublisher<CharacterList, Error>
}

struct HomeService: HomeServiceProtocol {
    static let shared: HomeService = {
        guard let manager = AppDelegate.sharedNetworkManager else {
            preconditionFailure("Forget network manager? ")
        }
        return HomeService(networkManager: manager)
    }()
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCharacters() -> AnyPublisher<CharacterList, Error> {
        let request = HTTPRequest<EmptyData, CharacterList>(endpont: EndPoint.all)
        return self.networkManager.request(request)
    }
}
