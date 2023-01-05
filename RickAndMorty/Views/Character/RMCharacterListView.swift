//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(_ characterListView: RMCharacterListView,
                             didSelectCharacter character: RMCharacter)
}

/// View that handles showing list of characters, loader, etc..
final class RMCharacterListView: UIView {

    // MARK: - Properties
    private let viewModel = RMCharacterListViewModel()
    public weak var delegate: RMCharacterListViewDelegate? = nil
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isHidden = true
        cv.showsVerticalScrollIndicator = false
        cv.alpha = 0
        cv.register(RMCharacterCell.self, forCellWithReuseIdentifier: RMCharacterCell.cellID)
        cv.register(RMFooterLoadingView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: RMFooterLoadingView.identifier)
        return cv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews(collectionView,spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) { fatalError("Unsupported") }
    
    // MARK: - Helpers
    private func addConstraints() {
        spinner.setDimensions(height: 100, width: 100)
        spinner.centerInSuperview()
        collectionView.fillSuperview()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

// MARK: - RMCharacterListViewModelDelegate
extension RMCharacterListView: RMCharacterListViewModelDelegate {
    
    func didLoadInitialCharacters() {
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
        UIView.animate(withDuration: 0.4) { self.collectionView.alpha = 1 }
    }
    
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        self.collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
}
