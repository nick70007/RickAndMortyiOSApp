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
    private let detailsView = RMCharacterDetailsView()
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("Unsupported") }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailsView)
        self.addBarButton()
        self.addConstraints()
    }
    
    // MARK: - Helpers
    private func addConstraints() {
        self.detailsView.fillSuperviewSafeAreaLayoutGuide()
    }
   
    private func addBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
    }
    
    // MARK: - Selectors
    @objc func didTapShare() {
        /// share character info
    }
}
