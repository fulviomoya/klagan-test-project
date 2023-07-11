//
//  LoadingViewCell.swift
//  RickAndMorty
//

import UIKit


class LoadingViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: LoadingViewCell.self)
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    private var mainStack = UIStackView()

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    // MARK: - Setup Methods
    
    func initialSetup() {
        self.mainStack.axis = .vertical
        self.mainStack.alignment = .center
        self.mainStack.translatesAutoresizingMaskIntoConstraints = false
        self.mainStack.distribution = .equalCentering
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
         
        spinner.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(spinner)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading"
        label.textColor = .darkGray
        mainStack.addArrangedSubview(label)
        spinner.startAnimating()
    }
    
}
 
