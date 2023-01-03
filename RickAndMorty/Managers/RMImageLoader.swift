//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by iMac on 03/01/23.
//

import Foundation

/// Class that handles image loading & caching
final class RMImageLoader {
    
    // MARK: - Shared
    static let shared = RMImageLoader()
    
    // MARK: - Properties
    private var imageDataCache = NSCache<NSString,NSData>()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Helpers
    
    /// Get image content from URL
    /// - Parameters:
    ///   - url: Source URL
    ///   - completion: Callback
    public func downloadImage(url: URL,
                              completion: @escaping (Result<Data,Error>) -> ()) {
        
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data)) // NSData == Data | NSString == String
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(error ?? URLError.init(.badServerResponse)))
            }
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }.resume()
    }
}
