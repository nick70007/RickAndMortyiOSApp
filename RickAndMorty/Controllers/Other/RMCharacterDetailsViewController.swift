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
    private func addConstraints() { self.detailsView.fillSuperviewSafeAreaLayoutGuide() }
   
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
        
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
            case .photo: return 1
            case .information(let viewModels): return viewModels.count
            case .episodes(let viewModels): return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
            case .photo(let viewModel):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCell.cellID, for: indexPath) as? RMCharacterPhotoCell else {
                    fatalError()
                }
                cell.configure(with: viewModel)
                return cell
            case .information(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCell.cellID, for: indexPath) as? RMCharacterInfoCell else {
                    fatalError()
                }
                cell.configure(with: viewModels[indexPath.row])
                return cell
            case .episodes(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCell.cellID, for: indexPath) as? RMCharacterEpisodeCell else {
                    fatalError()
                }
                cell.configure(with: viewModels[indexPath.row])
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
            case .photo, .information: break
            case .episodes:
                let url = self.viewModel.episodes[indexPath.row]
                let vc = RMEpisodeDetailViewController(url: URL(string: url))
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
