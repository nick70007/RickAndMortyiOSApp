//
//  RMCharacterCellViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import Foundation

final class RMCharacterCellViewModel: Hashable, Equatable {
    
    // MARK: - Init
    internal init(characterName: String,
                  characterStatus: RMCharacterStatus,
                  characterImageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    // MARK: - Properties
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    public let characterImageURL: URL?
    public var characterStatusText: String { return "Status: \(characterStatus.text)"}
    
    // MARK: - Hashable & Equatable
    static func == (lhs: RMCharacterCellViewModel, rhs: RMCharacterCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
    
    // MARK: - Fetch Image
//    public func fetchImage(completion: @escaping (Result<Data,Error>) -> ()) {
//        guard let url = characterImageURL else { return completion(.failure(URLError.init(.badURL))) }
//        RMImageLoader.shared.downloadImage(url: url, completion: completion)
//    }
}
