//
//  RMCharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 01/01/23.
//

import UIKit

final class RMCharacterDetailsViewModel {
    
    // MARK: - Properties
    private let character: RMCharacter
    private var requestURL: URL? { return URL(string: character.url) }
    public var title: String { self.character.name.uppercased() }
    
    enum SectionType {
        case photo(_ viewModel: RMCharacterPhotoViewModel)
        case information(_ viewModels: [RMCharacterInfoViewModel])
        case episodes(_ viewModels: [RMCharacterEpisodeViewModel])
    }
    
    public var episodes: [String] {
        character.episode
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
        self.setupSections()
    }
    
    // MARK: - Sections
    private func setupSections() {
        self.sections = [.photo(.init(imageURL: URL(string: character.image))),
                         .information([
                            .init(type: .status, value: character.status.text),
                            .init(type: .gender, value: character.gender.rawValue),
                            .init(type: .type, value: character.type),
                            .init(type: .species, value: character.species),
                            .init(type: .origin, value: character.origin.name),
                            .init(type: .location, value: character.location.name),
                            .init(type: .created, value: character.created),
                            .init(type: .episodeCount, value: "\(character.episode.count)")
                         ]),
                         .episodes(character.episode.compactMap {
                            return RMCharacterEpisodeViewModel(episodeDataURL: URL(string: $0))
                         })
        ]
    }
    
    //MARK: - Layout
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 10,
                                                     trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                     leading: 2,
                                                     bottom: 2,
                                                     trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1.0),
                                        heightDimension: .absolute(150)),
                                        subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 5,
                                                     bottom: 10,
                                                     trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(0.8),
                                        heightDimension: .absolute(150)),
                                        subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
