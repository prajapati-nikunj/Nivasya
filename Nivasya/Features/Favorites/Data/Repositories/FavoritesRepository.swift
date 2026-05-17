// File: Features/Favorites/Data/Repositories/FavoritesRepository.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation

public final class FavoritesRepository: FavoritesRepositoryProtocol {
    private let userDefaults = UserDefaults.standard
    private let key = "com.Nivasya.favorites"
    
    public init() {}
    
    public func fetchFavorites() async throws -> [Property] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        return try JSONDecoder().decode([Property].self, from: data)
    }
    
    public func saveFavorite(_ property: Property) async throws {
        var favorites = try await fetchFavorites()
        if !favorites.contains(where: { $0.id == property.id }) {
            var mutableProperty = property
            mutableProperty.isFavorite = true
            favorites.append(mutableProperty)
            try save(favorites)
        }
    }
    
    public func removeFavorite(_ propertyID: UUID) async throws {
        var favorites = try await fetchFavorites()
        favorites.removeAll { $0.id == propertyID }
        try save(favorites)
    }
    
    public func isFavorite(_ propertyID: UUID) async throws -> Bool {
        let favorites = try await fetchFavorites()
        return favorites.contains(where: { $0.id == propertyID })
    }
    
    private func save(_ favorites: [Property]) throws {
        let data = try JSONEncoder().encode(favorites)
        userDefaults.set(data, forKey: key)
    }
}
