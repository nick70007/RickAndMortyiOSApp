//
//  RMCharacterListViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import Foundation
import UIKit

protocol RMCharacterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

/// View Model to handle character list view logic
final class RMCharacterListViewModel: NSObject {
    
    // MARK: - Properties
    public weak var delegate: RMCharacterListViewModelDelegate? = nil
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let vm = RMCharacterCellViewModel(characterName: character.name,
                                                  characterStatus: character.status,
                                                  characterImageURL: URL(string: character.image))
                cellViewModels.append(vm)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCellViewModel] = []
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    public var shouldShowLoadMoreIndicator: Bool { return apiInfo?.next != nil }
    
    // MARK: - Helpers
    
    /// Fetch initial set of characters (20)
    public func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests,
                                 type: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
                case .success(let model):
                    self?.characters = model.results
                    self?.apiInfo = model.info
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialCharacters()
                    }
                case .failure(let error): print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters() {
        
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCell.cellID, for: indexPath) as? RMCharacterCell else {
            fatalError("Unsupported Cell")
        }
        cell.configure(with: self.cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didSelectCharacter(self.characters[indexPath.row])
    }
}

// MARK: - UIScrollViewDelegate
extension RMCharacterListViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else { return }
    }
}
