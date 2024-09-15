//
//  UrlCacheManager.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 21/06/2023.
//

import Foundation
class CacheManager {
    static let shared = CacheManager()
    var cache: URLCache

    private init() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheDir = documentsDirectory.appendingPathComponent("cache")
        cache = URLCache(memoryCapacity: 16 * 1024 * 1024, diskCapacity: 80 * 1024 * 1024, directory: cacheDir)
    }
}
