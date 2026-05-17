//
//  FetchPropertiesUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

// MARK: - Protocol

/// Use case contract for fetching property listings.
public protocol FetchPropertiesUseCase: Sendable {
    /// Fetches all properties from the repository.
    func execute() async throws -> [Property]
    
    /// Fetches properties filtered by a specific category.
    func execute(for category: PropertyCategory) async throws -> [Property]
}

// MARK: - Implementation

public final class FetchPropertiesUseCaseImpl: FetchPropertiesUseCase {
    private let repository: PropertyRepositoryProtocol
    
    public init(repository: PropertyRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws -> [Property] {
        try await repository.fetchAllProperties()
    }
    
    public func execute(for category: PropertyCategory) async throws -> [Property] {
        try await repository.fetchProperties(for: category)
    }
}
