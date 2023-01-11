//
//  RMCharacterPhotoViewModel.swift
//  RickAndMorty
//
//  Created by iMac on 11/01/23.
//

import Foundation

final class RMCharacterPhotoViewModel {
    
    // MARK: - Properties
    private let imageURL: URL?
    
    // MARK: - Init
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    public func fetchImage(completion: @escaping (Result<URL, Error>) -> ()) {
        guard let imageURL = imageURL else {
            completion(.failure(URLError.init(.badURL)))
            return
        }
        completion(.success(imageURL))
    }
}
