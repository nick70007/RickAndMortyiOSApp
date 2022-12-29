//
//  RMCharacterCell.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import UIKit

/// Single cell for a character
class RMCharacterCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "RMCharacterCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.textColor = .label
        name.font = .systemFont(ofSize: 18, weight: .medium)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private let statusLabel: UILabel = {
        let status = UILabel()
        status.textColor = .secondaryLabel
        status.font = .systemFont(ofSize: 16, weight: .regular)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubViews(imageView,nameLabel,statusLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5),
        ])
        
        imageView.backgroundColor = .systemGreen
        nameLabel.backgroundColor = .red
        statusLabel.backgroundColor = .orange
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: RMCharacterCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        
        viewModel.fetchImage { [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage.init(data: data)
                    }
                case .failure(let error): print(String(describing: error))
            }
        }
    }
}
