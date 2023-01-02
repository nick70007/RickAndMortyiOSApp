//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by iMac on 28/12/22.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query parameters
    internal init(endpoint: RMEndpoint,
                  pathComponents: [String] = [],
                  queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        
        if !string.contains(Constants.BASE_URL) {
           return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.BASE_URL+"/", with: "")
        
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endPointString = components[0]
                if let rmEndPoint = RMEndpoint(rawValue: endPointString) {
                    self.init(endpoint: rmEndPoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endPointString = components[0]
                let queryItemString = components[1]
                let queryItems: [URLQueryItem] = queryItemString.components(separatedBy: "&").compactMap {
                    guard $0.contains("=") else { return nil }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                }
                if let rmEndPoint = RMEndpoint(rawValue: endPointString) {
                    self.init(endpoint: rmEndPoint, queryParameters: queryItems)
                    return
                }
            }
        }
        
        return nil
    }
    
    /// API Constants
    private struct Constants {
        static let BASE_URL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    
    /// Path components for API, if any
    private let pathComponents: [String]
    
    /// Query parameters for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the API request in the string format
    private var urlString: String {
        var str = Constants.BASE_URL
        str += "/"
        str += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                str += "/\($0)"
            }
        }
        
        if !queryParameters.isEmpty {
            str += "?"
            let argumentStr = queryParameters.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            
            str += argumentStr
        }
        
        return str
    }
    
    /// Computed & constructed API url
    public var url: URL? {
       return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}
