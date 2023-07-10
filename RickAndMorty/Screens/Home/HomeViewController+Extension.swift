//
//  HomeViewController+Ext.swift
//  RickAndMorty
//

import Foundation
import UIKit

// MARK : - CollectionViewDataSource
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100 //TODO: change to the correct value
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewController.cellIdentifier,
                                                      for: indexPath) as! CharacterViewCell
        
      //  let character = CharacterModel(id: 1, name: "Juan", species: "Humano")
        //cell.setup(with: character)
        return cell
    }
}

// MARK : - CollectionViewDelegate
extension HomeViewController : UICollectionViewDelegate {
    
   
}
