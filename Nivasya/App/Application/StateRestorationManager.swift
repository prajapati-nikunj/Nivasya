//
//  StateRestorationManager.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public final class StateRestorationManager {
    public static let shared = StateRestorationManager()
    private let userDefaults = UserDefaults.standard
    private let lastRouteKey = "com.Nivasya.lastRoute"
    
    private init() {}
    
    /// Saves the current navigation state.
    public func saveState(route: AppRoute) {
        if let data = try? JSONEncoder().encode(route) {
            userDefaults.set(data, forKey: lastRouteKey)
        }
    }
    
    /// Retrieves the last saved navigation state.
    public func restoreState() -> AppRoute? {
        guard let data = userDefaults.data(forKey: lastRouteKey) else { return nil }
        return try? JSONDecoder().decode(AppRoute.self, from: data)
    }
    
    /// Clears the saved state.
    public func clearState() {
        userDefaults.removeObject(forKey: lastRouteKey)
    }
}
