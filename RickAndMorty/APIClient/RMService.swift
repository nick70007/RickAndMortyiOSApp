//
//  RMService.swift
//  RickAndMorty
//
//  Created by iMac on 28/12/22.
//

import Foundation

/// Primary API service object to get Rick & Morty data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init() {}
    
    /// Custom API Service Error
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send Rick & Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest,
                                    type: T.Type,
                                    completion: @escaping (Result<T,Error>) -> ()) {
        guard let urlRequest = self.request(from: request) else {
            return completion(.failure(RMServiceError.failedToCreateRequest))
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(error ?? RMServiceError.failedToGetData))
            }
            
            /// Decode Response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK:- Private Methods
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
