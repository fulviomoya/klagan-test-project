//
//  HomeViewController+Ext.swift
//  RickAndMorty
//

import Foundation
import UIKit

// MARK: - CollectionViewDataSource
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterListPublisher.value.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == viewModel.characterListPublisher.value.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingViewCell.reuseIdentifier,
                                                                for: indexPath) as? LoadingViewCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterViewCell.reusableIdentifier,
                                                          for: indexPath) as! CharacterViewCell
            
            viewModel.fetchImage(thumbnailURL: viewModel.characterListPublisher.value[indexPath.row].image)
            cell.setupView(withModel: viewModel.characterListPublisher.value[indexPath.row], viewModel: viewModel)
            return cell
        }
    }
} 

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == viewModel.characterListPublisher.value.count {
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: AppSpacing.spacing2, left: AppSpacing.spacing2,
                                               bottom: AppSpacing.spacing2, right: AppSpacing.spacing2)
            
            //the item width must be less than the width of the UICollectionView
            //minus the section insets left and right values,
            //minus the content insets left and right values.
            return CGSize(width: view.frame.width - (AppSpacing.spacing2 * 2),
                          height: HomeViewController.cellHeight)
            
        }
    
        return CGSize(width: view.frame.width * 0.46, height: HomeViewController.cellHeight)
    }
}
