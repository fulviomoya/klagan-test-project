//
//  HomeViewController.swift
//  RickAndMorty
//

import UIKit

class HomeViewController: UIViewController {
    
    private static let cellIdentifier = String(describing: HomeViewController.self)
    private static let verticalSpacing = AppSpacing.spacing2
    
    static let cellHeight: CGFloat = {
        return (AppSpacing.spacing7 + verticalSpacing) * 2
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width * 0.44, height: HomeViewController.cellHeight)
        layout.sectionInset = UIEdgeInsets(top: AppSpacing.spacing4, left: AppSpacing.spacing4,
                                           bottom: AppSpacing.spacing4, right: AppSpacing.spacing4)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AppColor.gray200
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewGrid(to: self.view)
    }
    
    private func setupCollectionViewGrid(to parent: UIView){
        view.addSubview(collectionView)
        
        collectionView.register(CharacterViewCell.self, forCellWithReuseIdentifier: HomeViewController.cellIdentifier)
        collectionView.dataSource = self
        
        // Activate constraints
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: parent.topAnchor, constant: AppSpacing.spacing9),
            collectionView.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -AppSpacing.spacing4),
        ])
    }
}

// MARK : - ViewDataSource
extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100 //TODO: change to the correct value
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TODO: Search best practice to deque...
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewController.cellIdentifier,
                                                      for: indexPath) as! CharacterViewCell
        
        let character = CharacterModel(id: 1, name: "Juan", species: "Humano")
        cell.setup(with: character)
        return cell
    }
    
}
