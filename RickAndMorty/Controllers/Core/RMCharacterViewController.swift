//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by iMac on 28/12/22.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    // MARK: - Properties
    private let charactersListView = RMCharacterListView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        title = "Characters"
        self.setupViews()
    }
    
    // MARK: - Helpers
    private func setupViews() {
        view.addSubview(charactersListView)
        charactersListView.delegate = self
        charactersListView.fillSuperviewSafeAreaLayoutGuide()
    }
}
 
// MARK: - RMCharacterListViewDelegate
extension RMCharacterViewController: RMCharacterListViewDelegate {
    
    func rmCharacterListView(_ characterListView: RMCharacterListView,
                             didSelectCharacter character: RMCharacter) {
        let vm = RMCharacterDetailsViewModel(character: character)
        let detailsVC = RMCharacterDetailsViewController(viewModel: vm)
        detailsVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
