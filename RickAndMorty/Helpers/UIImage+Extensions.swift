//
//  UIImage+Extensions.swift
//  RickAndMorty
//

import UIKit

extension UIImage {
    
    static var placeholder: UIImage {
        guard let image = UIImage(named: "placeholder") else {
            preconditionFailure("Asset missing")
        }
        return image
    }
}
