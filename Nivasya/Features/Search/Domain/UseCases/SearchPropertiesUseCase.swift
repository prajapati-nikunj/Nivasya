//
//  SearchPropertiesUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

// MARK: - Protocol

/// Use case contract for searching property listings.
public protocol SearchPropertiesUseCase: Sendable {
    /// Executes a search query and returns matching properties.
    func execute(query: String) async throws -> [Property]
}

// MARK: - Implementation

public final class SearchPropertiesUseCaseImpl: SearchPropertiesUseCase {
    private let repository: SearchRepositoryProtocol
    
    public init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(query: String) async throws -> [Property] {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return []
        }
        return try await repository.searchProperties(query: query)
    }
}
