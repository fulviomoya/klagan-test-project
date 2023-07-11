//
//  HomeViewController.swift
//  RickAndMorty
//

import UIKit

class HomeViewController: UIViewController {
     
    var viewModel = HomeViewModel(service: HomeService.shared)
    
    static let cellHeight: CGFloat = {
        return (AppSpacing.spacing7 + AppSpacing.spacing2) * 2
    }()
    
    private lazy var flowLayou: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: AppSpacing.spacing4, left: AppSpacing.spacing4,
                                           bottom: AppSpacing.spacing4, right: AppSpacing.spacing4)
        //layout.itemSize = CGSize(width: view.frame.width * 0.44, height: HomeViewController.cellHeight)
        layout.itemSize = CGSize(width: view.frame.width, height: HomeViewController.cellHeight)
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayou)
        collectionView.register(CharacterViewCell.self,
                                    forCellWithReuseIdentifier: CharacterViewCell.reusableIdentifier)
        
        collectionView.register(LoadingViewCell.self,
                                    forCellWithReuseIdentifier: LoadingViewCell.reuseIdentifier)
      
        collectionView.backgroundColor = AppColor.gray200
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        //collectionView.delegate = self
        collectionView.dataSource = self
        
        setupCollectionViewGrid(to: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.navigationController?.setNavigationBarHidden(false, animated: animated) //TODO: Check this
        viewModel.fetchCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.cancel()
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
