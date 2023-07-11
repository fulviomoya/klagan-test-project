//
//  CharacterViewCell.swift
//  RickAndMorty
//

import UIKit

class CharacterViewCell: UICollectionViewCell {
    private static let iconWrapperWidth: CGFloat = AppSpacing.spacing8
        
    static let reusableIdentifier: String = String(describing: CharacterViewCell.self)
    
    private lazy var thumbnailImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = CharacterViewCell.iconWrapperWidth / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = AppTextStyle.xs.bold.font
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = AppTextStyle.xs.font
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // must call super
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    // we have to implement this initializer, but will only ever use this class programmatically
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(thumbnailImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpacing.spacing3),
            thumbnailImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            thumbnailImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            thumbnailImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImage.topAnchor, constant: AppSpacing.spacing1),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: AppSpacing.spacing2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpacing.spacing1),
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: AppSpacing.spacing1),
            valueLabel.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: AppSpacing.spacing2),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpacing.spacing1),
        ])
    }
    
    func setupView(withViewModel character: CharacterModel) {
        self.backgroundColor = .white
        self.thumbnailImage.image = UIImage(named: "default_image")
        self.titleLabel.text = character.name
        self.valueLabel.text = character.species
    }
}
