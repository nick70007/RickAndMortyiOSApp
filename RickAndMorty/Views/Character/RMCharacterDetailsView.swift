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
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPurple
        self.collectionView = createCollectionView()
        guard let cv = collectionView else { return }
        addSubViews(cv,spinner)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
    }
}
