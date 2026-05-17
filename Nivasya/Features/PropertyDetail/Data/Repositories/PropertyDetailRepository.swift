//
//  PropertyDetailRepository.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Data-layer implementation for property detail.
/// Delegates to the shared PropertyRepositoryProtocol.
/// In production, this could call a dedicated detail API endpoint with richer data.
public final class PropertyDetailRepository: PropertyDetailRepositoryProtocol {
    private let propertyRepository: PropertyRepositoryProtocol
    
    public init(propertyRepository: PropertyRepositoryProtocol) {
        self.propertyRepository = propertyRepository
    }
    
    public func fetchPropertyDetail(id: UUID) async throws -> Property? {
        try await propertyRepository.fetchProperty(by: id)
    }
}
