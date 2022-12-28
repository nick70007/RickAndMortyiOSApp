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
    
    /// Send Rick & Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest,
                                    type: T.Type,
                                    completion: @escaping (Result<T,Error>) -> ()) {
        
    }
}
