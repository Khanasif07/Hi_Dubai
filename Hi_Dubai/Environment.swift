//
//  Environment.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 05/06/2023.
//

import Foundation
enum Environment: String { // 1
    case debugDevelopment = "Debug Development"
    case releaseDevelopment = "Release Development"

    case debugStaging = "Debug Staging"
    case releaseStaging = "Release Staging"

    case debugProduction = "Debug Production"
    case releaseProduction = "Release Production"
}


class BuildConfiguration {
    static let shared = BuildConfiguration()
    
    var environment: Environment
    
    var baseURL: String { // 1
        switch environment {
        case .debugStaging, .releaseStaging:
            return "https://staging.example.com/api"
        case .debugDevelopment, .releaseDevelopment:
            return "https://dev.example.com/api"
        case .debugProduction, .releaseProduction:
            return "https://example.com/api"
        }
    }
    
    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String ?? ""
        
        environment = Environment(rawValue: currentConfiguration)!
    }
}
