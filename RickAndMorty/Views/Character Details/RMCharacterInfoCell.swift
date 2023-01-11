//
//  RMCharacterInfoCell.swift
//  RickAndMorty
//
//  Created by iMac on 11/01/23.
//

import UIKit

final class RMCharacterInfoCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "RMCharacterInfoCell"
    
    private let valueLabel: UILabel = {
        let value = UILabel()
        value.textAlignment = .left
        value.font = .systemFont(ofSize: 22, weight: .light)
        value.numberOfLines = 0
        return value
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 20, weight: .medium)
        return title
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.customCornerRadius(radius: 8)
        contentView.addSubViews(valueLabel,titleContainerView,iconImageView)
        titleContainerView.addSubview(titleLabel)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("Unsupported") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.valueLabel.text = nil
        self.titleLabel.text = nil
        self.iconImageView.image = nil
        self.titleLabel.textColor = .label
        self.iconImageView.tintColor = .label
    }
    
    // MARK: - Methods
    private func setupConstraints() {
        titleContainerView.anchor(top: nil,
                                  leading: contentView.leadingAnchor,
                                  bottom: contentView.bottomAnchor,
                                  trailing: contentView.trailingAnchor)
        titleContainerView.constrainHeight(contentView.heightAnchor, multiplier: 0.33)
        titleLabel.centerInSuperview()
        iconImageView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             paddingTop: 15,
                             paddingLeft: 15,
                             width: 30,
                             height: 30)
        valueLabel.anchor(top: iconImageView.topAnchor,
                          left: iconImageView.rightAnchor,
                          right: contentView.rightAnchor,
                          paddingLeft: 10,
                          paddingRight: 10)
    }
    
    public func configure(with viewModel: RMCharacterInfoViewModel) {
        self.titleLabel.text = viewModel.title
        self.titleLabel.textColor = viewModel.tintColor
        self.valueLabel.text = viewModel.displayValue
        self.iconImageView.image = viewModel.iconImage
        self.iconImageView.tintColor = viewModel.tintColor
    }
}
