//
//  ToggleFavoriteUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

// MARK: - Protocol

/// Use case contract for toggling a property's favorite state.
public protocol ToggleFavoriteUseCase: Sendable {
    /// Adds or removes a property from favorites.
    /// Returns `true` if the property is now a favorite, `false` otherwise.
    func execute(property: Property) async throws -> Bool
}

// MARK: - Implementation

public final class ToggleFavoriteUseCaseImpl: ToggleFavoriteUseCase {
    private let repository: FavoritesRepositoryProtocol
    
    public init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(property: Property) async throws -> Bool {
        let currentlyFavorite = try await repository.isFavorite(property.id)
        
        if currentlyFavorite {
            try await repository.removeFavorite(property.id)
            return false
        } else {
            try await repository.saveFavorite(property)
            return true
        }
    }
}
