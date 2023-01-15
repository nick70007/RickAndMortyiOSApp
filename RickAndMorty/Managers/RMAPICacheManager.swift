//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by iMac on 14/01/23.
//

import Foundation

/// Manages in memory session scoped API caches
final class RMAPICacheManager {
    
    // MARK: - Properties
    private var cacheDictionary: [RMEndpoint: NSCache<NSString,NSData>] = [:]
    
    // MARK: - Init
    init() { self.setupCache() }
    
    // MARK: - Helpers
    private func setupCache() {
        RMEndpoint.allCases.forEach { cacheDictionary[$0] = NSCache<NSString,NSData>() }
    }
    
    public func cachedResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else { return nil }
        let key = url.absoluteString as NSString
        guard let cache = targetCache.object(forKey: key) else { return nil }
        return Data(referencing: cache)
    }
    
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else { return }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
}
