//
//  RMCharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by iMac on 01/01/23.
//

import UIKit

/// Controller to show info about single character
final class RMCharacterDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: RMCharacterDetailsViewModel
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
