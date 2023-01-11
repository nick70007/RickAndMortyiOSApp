//
//  RMCharacterEpisodeViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 11/01/23.
//

import Foundation

final class RMCharacterEpisodeViewModel {
    
    // MARK: - Properties
    private let episodeDataURL: URL?
    
    // MARK: - Init
    init(episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
}
