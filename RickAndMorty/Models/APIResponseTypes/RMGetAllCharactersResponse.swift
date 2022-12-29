//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
    
}
