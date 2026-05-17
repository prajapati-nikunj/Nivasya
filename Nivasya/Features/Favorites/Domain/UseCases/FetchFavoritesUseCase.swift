//
//  FetchFavoritesUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

// MARK: - Protocol

/// Use case contract for fetching the user's favorite properties.
public protocol FetchFavoritesUseCase: Sendable {
    /// Returns all properties the user has marked as favorites.
    func execute() async throws -> [Property]
}

// MARK: - Implementation

public final class FetchFavoritesUseCaseImpl: FetchFavoritesUseCase {
    private let repository: FavoritesRepositoryProtocol
    
    public init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws -> [Property] {
        try await repository.fetchFavorites()
    }
}
