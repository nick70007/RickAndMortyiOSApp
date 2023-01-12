//
//  RMCharacterEpisodeCell.swift
//  RickAndMorty
//
//  Created by iMac on 11/01/23.
//

import UIKit

final class RMCharacterEpisodeCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "RMCharacterEpisodeCell"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.customCornerRadius(radius: 8)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("Unsupported") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Methods
    private func setupConstraints() {
        
    }
    
    public func configure(with viewModel: RMCharacterEpisodeViewModel) {
        viewModel.registerForData { data in
            print(data.name)
            print(data.air_date)
            print(data.episode)
        }
        
        viewModel.fetchEpisode()
    }
}
