//
//  RMCharacterPhotoCell.swift
//  RickAndMorty
//
//  Created by iMac on 11/01/23.
//

import UIKit
import SDWebImage

final class RMCharacterPhotoCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "RMCharacterPhotoCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("Unsupported") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    // MARK: - Methods
    private func setupConstraints() { self.imageView.fillSuperview() }
    
    public func configure(with viewModel: RMCharacterPhotoViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
                case .success(let imageURL):
                    self?.imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
                    self?.imageView.sd_setImage(with: imageURL)
                case .failure: break
            }
        }
    }
}
