// File: Features/Favorites/Domain/Repositories/FavoritesRepositoryProtocol.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation

public protocol FavoritesRepositoryProtocol: Sendable {
    func fetchFavorites() async throws -> [Property]
    func saveFavorite(_ property: Property) async throws
    func removeFavorite(_ propertyID: UUID) async throws
    func isFavorite(_ propertyID: UUID) async throws -> Bool
}
