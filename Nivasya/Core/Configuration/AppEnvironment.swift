//
//  AppEnvironment.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Defines the execution environments for the Nivasya application.
public enum AppEnvironment: String, CaseIterable, Sendable {
    case development = "dev"
    case staging = "stg"
    case production = "prod"
    
    public var name: String {
        switch self {
        case .development: return "Development"
        case .staging: return "Staging"
        case .production: return "Production"
        }
    }
    
    public var apiBaseURL: URL {
        let urlString: String
        switch self {
        case .development:
            urlString = "https://dev-api.nivasya.luxury"
        case .staging:
            urlString = "https://stg-api.nivasya.luxury"
        case .production:
            urlString = "https://api.nivasya.luxury"
        }
        
        guard let url = URL(string: urlString) else {
            fatalError("Failed to construct API base URL for environment \(self.name)")
        }
        return url
    }
}
