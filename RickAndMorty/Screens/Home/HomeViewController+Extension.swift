//
//  HomeViewController+Ext.swift
//  RickAndMorty
//

import Foundation
import UIKit

// MARK : - CollectionViewDataSource
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterList.value.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == viewModel.characterList.value.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingViewCell.reuseIdentifier,
                                                                for: indexPath) as? LoadingViewCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterViewCell.reusableIdentifier,
                                                          for: indexPath) as! CharacterViewCell
            
            cell.setupView(withViewModel: viewModel.characterList.value[indexPath.row])
            /* cell.setupView(withViewModel: CharacterModel(Character(id: 1, name: "asdf", status: "asdf", species: "asdf", type: "asdf", gender: "asdf", origin: Character.BasicInformation(name: "asdf", url: "adsf"), location: Character.BasicInformation(name: "adsf", url: "asdf"), image: "") ))*/
            return cell
        }
    }
} 
