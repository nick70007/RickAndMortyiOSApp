//
//  RMCharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by iMac on 01/01/23.
//

import UIKit
import LeakedViewControllerDetector

/// Controller to show info about single character
final class RMCharacterDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: RMCharacterDetailsViewModel
    private let detailsView: RMCharacterDetailsView
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailsViewModel) {
        self.viewModel = viewModel
        self.detailsView = RMCharacterDetailsView(frame: .zero, viewModel: viewModel)
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
        self.detailsView.collectionView?.delegate = self
        self.detailsView.collectionView?.dataSource = self
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

// MARK: - UICollectionViewDelegate/UICollectionViewDataSource
extension RMCharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: return 8
            case 2: return 10
            default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemBlue
        } else {
            cell.backgroundColor = .systemGreen
        }
        return cell
    }
}
