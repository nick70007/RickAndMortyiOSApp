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
        charactersListView.fillSuperviewSafeAreaLayoutGuide()
    }
}
