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
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        self.character.name.uppercased()
    }
}
