//
//  AppConfiguration.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import Observation

/// Central configuration manager for the application state and environment.
@Observable
public final class AppConfiguration {
    public let environment: AppEnvironment
    public let featureFlags: FeatureFlags
    
    public init(environment: AppEnvironment = .development) {
        self.environment = environment
        self.featureFlags = FeatureFlags(for: environment)
    }
}

/// Feature flags to guard experimental or environment-specific functionality.
public struct FeatureFlags {
    public let enableVirtualTours: Bool
    public let enableAIMortgageAdvisor: Bool
    public let enableARPropertyPreview: Bool
    
    public init(for environment: AppEnvironment) {
        switch environment {
        case .production:
            self.enableVirtualTours = true
            self.enableAIMortgageAdvisor = false
            self.enableARPropertyPreview = false
        case .staging:
            self.enableVirtualTours = true
            self.enableAIMortgageAdvisor = true
            self.enableARPropertyPreview = false
        case .development:
            self.enableVirtualTours = true
            self.enableAIMortgageAdvisor = true
            self.enableARPropertyPreview = true
        }
    }
}
