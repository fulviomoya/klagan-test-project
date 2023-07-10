//
//  HomeViewController.swift
//  RickAndMorty
//

import UIKit

class HomeViewController: UIViewController {
     
    static let cellIdentifier = String(describing: HomeViewController.self)
    
    static let cellHeight: CGFloat = {
        return (AppSpacing.spacing7 +  AppSpacing.spacing2) * 2
    }()
    
    private lazy var flowLayou: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: AppSpacing.spacing4, left: AppSpacing.spacing4,
                                           bottom: AppSpacing.spacing4, right: AppSpacing.spacing4)
        layout.itemSize = CGSize(width: view.frame.width * 0.44, height: HomeViewController.cellHeight)
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayou)
        collectionView.register(CharacterViewCell.self,
                                    forCellWithReuseIdentifier: HomeViewController.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = AppColor.gray200
       
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        setupCollectionViewGrid(to: self.view)
    }
    
    private func setupCollectionViewGrid(to parent: UIView){
       
        // Activate constraints
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: parent.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -AppSpacing.spacing4),
        ])
    }
}
