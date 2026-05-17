//
//  FetchPropertyDetailUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

// MARK: - Protocol

/// Use case contract for fetching a single property's full details.
public protocol FetchPropertyDetailUseCase: Sendable {
    /// Fetches the complete detail for a given property ID.
    func execute(id: UUID) async throws -> Property?
}

// MARK: - Implementation

public final class FetchPropertyDetailUseCaseImpl: FetchPropertyDetailUseCase {
    private let repository: PropertyDetailRepositoryProtocol
    
    public init(repository: PropertyDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(id: UUID) async throws -> Property? {
        try await repository.fetchPropertyDetail(id: id)
    }
}
