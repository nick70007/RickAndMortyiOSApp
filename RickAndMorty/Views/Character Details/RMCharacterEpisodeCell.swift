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
    
    private let seasonLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        return title
    }()
    
    private let nameLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 22, weight: .regular)
        return title
    }()
    
    private let airDateLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 18, weight: .light)
        return title
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.setCornerRadiusAndBorder(radius: 8, borderWidth: 2, borderColor: .systemBlue)
        contentView.addSubViews(seasonLabel,nameLabel,airDateLabel)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("Unsupported") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.seasonLabel.text = nil
        self.nameLabel.text = nil
        self.airDateLabel.text = nil
    }
    
    // MARK: - Methods
    private func setupConstraints() {
        seasonLabel.anchor(top: contentView.topAnchor,
                           left: contentView.leftAnchor,
                           bottom: nameLabel.topAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 10,
                           paddingBottom: 0,
                           paddingRight: 10)
        seasonLabel.constrainHeight(contentView.heightAnchor, multiplier: 0.3)
        
        nameLabel.anchor(top: nil,
                         left: contentView.leftAnchor,
                         bottom: airDateLabel.topAnchor,
                         right: contentView.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 10,
                         paddingBottom: 0,
                         paddingRight: 10)
        nameLabel.constrainHeight(contentView.heightAnchor, multiplier: 0.3)
        
        airDateLabel.anchor(top: nil,
                            left: contentView.leftAnchor,
                            bottom: nil,
                            right: contentView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 10,
                            paddingBottom: 0,
                            paddingRight: 10)
        airDateLabel.constrainHeight(contentView.heightAnchor, multiplier: 0.3)
    }
    
    public func configure(with viewModel: RMCharacterEpisodeViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.seasonLabel.text = "Episode "+data.episode
            self?.nameLabel.text = data.name
            self?.airDateLabel.text = "Aired on "+data.air_date
        }
        
        viewModel.fetchEpisode()
    }
}
