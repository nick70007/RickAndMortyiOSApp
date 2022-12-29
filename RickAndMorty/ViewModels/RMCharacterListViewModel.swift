//
//  RMCharacterListViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import Foundation
import UIKit

final class RMCharacterListViewModel: NSObject {
    
    // MARK: - Helpers
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests,
                                 type: RMGetAllCharactersResponse.self) { result in
            switch result {
                case .success(let model): print(String(describing: model))
                case .failure(let error): print(String(describing: error))
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCell.cellID, for: indexPath) as? RMCharacterCell else {
            fatalError("Unsupported Cell")
        }
        let viewModel = RMCharacterCellViewModel(characterName: "Nishant",
                                                 characterStatus: .alive,
                                                 characterImageURL: nil)
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
}
