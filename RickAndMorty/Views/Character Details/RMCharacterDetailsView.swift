//
//  RMCharacterDetailsView.swift
//  RickAndMorty
//
//  Created by iMac on 01/01/23.
//

import UIKit

/// View for displaying single character info
final class RMCharacterDetailsView: UIView {

    // MARK: - Properties
    public var collectionView: UICollectionView?
    private let viewModel: RMCharacterDetailsViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Init
    init(frame: CGRect, viewModel: RMCharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubViews(collectionView,spinner)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("Unsupported") }
    
    // MARK: - Helpers
    private func addConstraints() {
        guard let cv = collectionView else { return }
        spinner.setDimensions(height: 100, width: 100)
        spinner.centerInSuperview()
        cv.fillSuperview()
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterPhotoCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCell.cellID)
        collectionView.register(RMCharacterInfoCell.self, forCellWithReuseIdentifier: RMCharacterInfoCell.cellID)
        collectionView.register(RMCharacterEpisodeCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCell.cellID)
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch viewModel.sections[sectionIndex] {
            case .photo: return viewModel.createPhotoSectionLayout()
            case .information: return viewModel.createInfoSectionLayout()
            case .episodes: return viewModel.createEpisodeSectionLayout()
        }
    }
}
