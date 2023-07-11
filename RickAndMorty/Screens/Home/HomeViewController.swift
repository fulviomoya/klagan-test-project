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
        
        setupNavigationBarAppearance()
        setupCollectionViewGridConstraints(to: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindingAndRefreshLoadedData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.cancel()
    }
    
    fileprivate func setupNavigationBarAppearance() {
        navigationItem.title = "List of Characters" //TODO: Localizable...
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1) //TODO: Remove hardcode
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    fileprivate func bindingAndRefreshLoadedData() {
        viewModel.characterListPublisher.sink { [weak self] newValue in
            guard let self = self else { return }
            if !newValue.isEmpty {
                collectionView.reloadData()
                collectionView.layoutIfNeeded()
            }
        }.store(in: &cancellables)
        self.view.layoutIfNeeded()
    }
    
    private func setupCollectionViewGridConstraints(to parent: UIView){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: parent.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -AppSpacing.spacing4),
        ])
    }
}
