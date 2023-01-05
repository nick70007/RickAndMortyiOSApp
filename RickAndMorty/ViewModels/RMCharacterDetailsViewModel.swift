//
//  RMCharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 01/01/23.
//

import Foundation

final class RMCharacterDetailsViewModel {
    
    // MARK: - Properties
    private let character: RMCharacter
    private var requestURL: URL? { return URL(string: character.url) }
    public var title: String { self.character.name.uppercased() }
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
    }
}
