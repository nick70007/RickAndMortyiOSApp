//
//  RMCharacterCellViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 29/12/22.
//

import Foundation

final class RMCharacterCellViewModel {
    
    // MARK: - Init
    internal init(characterName: String, characterStatus: RMCharacterStatus, characterImageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    // MARK: - Properties
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> ()) {
        
        // TODO: Abstract to Image Manager
        guard let url = characterImageURL else {
            return completion(.failure(URLError.init(.badURL)))
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(error ?? URLError.init(.badServerResponse)))
            }
            completion(.success(data))
        }.resume()
    }
}
