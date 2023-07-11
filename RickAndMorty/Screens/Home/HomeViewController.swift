//
//  HomeViewController.swift
//  RickAndMorty
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel(service: HomeService.shared)
    var cancellables: Set<AnyCancellable> = []
    
    static let cellHeight: CGFloat = {
        return (AppSpacing.spacing7 + AppSpacing.spacing2) * 2
    }()
  
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupCollectionViewGrid(to: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated) //TODO: Check this
        viewModel.fetchCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.characterList.sink { [weak self] newValue in
            guard let self = self else { return }
            if !newValue.isEmpty {
                collectionView.reloadData()
                collectionView.layoutIfNeeded()
            }
        }.store(in: &cancellables)
        
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
