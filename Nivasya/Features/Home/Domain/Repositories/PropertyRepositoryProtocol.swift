//
//  PropertyRepositoryProtocol.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Domain-layer contract for property data access.
/// Concrete implementations live in the Data layer.
public protocol PropertyRepositoryProtocol: Sendable {
    /// Fetches all available properties.
    func fetchAllProperties() async throws -> [Property]
    
    /// Fetches a single property by its identifier.
    func fetchProperty(by id: UUID) async throws -> Property?
    
    /// Fetches properties filtered by category.
    func fetchProperties(for category: PropertyCategory) async throws -> [Property]
}
