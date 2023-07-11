//
//  Bundle+Entension.swift
//  RickAndMorty
//

import Foundation

extension Bundle {
    static var baseURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String
    }
}
