//
//  ImageService.swift
//  RickAndMorty
//

import Foundation
import UIKit
import Combine

protocol ImageServiceProtocol {
    static func fetchImage(from url: URL) -> AnyPublisher<UIImage, Error>
}

class ImageService: ImageServiceProtocol {
    private static var backgroundSchduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()
    
    static func fetchImage(from url: URL) -> AnyPublisher<UIImage, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap ({ (data: Data, response: URLResponse) in
                guard let image = UIImage(data: data) else {
                    throw URLError(.resourceUnavailable)
                }
                return image
            })
            .subscribe(on: backgroundSchduler)
            .receive(on: RunLoop.main)
            //.eraseToAnyPublisher()
    }
}
