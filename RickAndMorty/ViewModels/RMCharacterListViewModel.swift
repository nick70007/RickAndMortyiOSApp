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
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
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
                if !cellViewModels.contains(vm) {
                    cellViewModels.append(vm)
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCellViewModel] = []
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    private var isLoadingMoreCharacters = false
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
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else { return }
        isLoadingMoreCharacters = true
        print("Fetching more characters")
        
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            print("Failed to create request")
            return
        }
        
        RMService.shared.execute(request,
                                 type: RMGetAllCharactersResponse.self) { [weak self] result in
            
            guard let strongSelf = self else { return }
            
            switch result {
                case .success(let model):
                    strongSelf.apiInfo = model.info
                    let originalCount = strongSelf.characters.count
                    let newCount = model.results.count
                    let total = originalCount + newCount
                    let startIndex = total - newCount
                    let indexPathsToAdd: [IndexPath] = Array(startIndex..<(startIndex+newCount)).compactMap {
                        return IndexPath(row: $0, section: 0)
                    }
                    strongSelf.characters.append(contentsOf: model.results)
                    DispatchQueue.main.async {
                        strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                        strongSelf.isLoadingMoreCharacters = false
                    }
                case .failure(let error):
                    print(String(describing: error))
                    strongSelf.isLoadingMoreCharacters = false
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported")
        }
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: RMFooterLoadingView.identifier,
                                                                           for: indexPath) as? RMFooterLoadingView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 100)
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
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextURL = self.apiInfo?.next,
              let url = URL(string: nextURL) else {
                  return
              }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCharacters(url: url)
            }
            
            timer.invalidate()
        }
    }
}
