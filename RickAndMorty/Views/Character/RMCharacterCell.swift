//
//  RMCharacterCell.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import UIKit
import SDWebImage

/// Single cell for a character
final class RMCharacterCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "RMCharacterCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.textColor = .label
        name.font = .systemFont(ofSize: 18, weight: .medium)
        return name
    }()
    
    private let statusLabel: UILabel = {
        let status = UILabel()
        status.textColor = .secondaryLabel
        status.font = .systemFont(ofSize: 16, weight: .regular)
        return status
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubViews(imageView,nameLabel,statusLabel)
        addConstraints()
        setupShadow()
    }
    
    required init?(coder: NSCoder) { fatalError("Unsupported") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupShadow()
    }
    
    // MARK: - Private Methods
    private func setupShadow() {
        contentView.setCellDropShadow(cornerRadius: 8,
                                      shadowRadius: 1.7,
                                      shadowColor: .label,
                                      shadowOpacity: 0.4,
                                      offsetWidth: 0,
                                      offsetHeight: 1.75)
        imageView.roundSpecificCorners(corners: [.topLeft,.topRight], radius: 8)
    }
    
    private func addConstraints() {
        nameLabel.constrainHeight(30)
        statusLabel.constrainHeight(30)
        nameLabel.anchor(left: contentView.leftAnchor,
                         bottom: statusLabel.topAnchor,
                         right: contentView.rightAnchor,
                         paddingLeft: 7,
                         paddingRight: 7)
        statusLabel.anchor(left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingLeft: 7,
                           paddingBottom: 3,
                           paddingRight: 7)
        imageView.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         bottom: nameLabel.topAnchor,
                         right: contentView.rightAnchor,
                         paddingBottom: 3)
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: RMCharacterCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        guard let url = viewModel.characterImageURL else { return }
        self.imageView.sd_setImage(with: url)
//        viewModel.fetchImage { [weak self] result in
//            switch result {
//                case .success(let data):
//                    DispatchQueue.main.async {
//                        self?.imageView.image = UIImage.init(data: data)
//                    }
//                case .failure(let error): print(String(describing: error))
//            }
//        }
    }
}
