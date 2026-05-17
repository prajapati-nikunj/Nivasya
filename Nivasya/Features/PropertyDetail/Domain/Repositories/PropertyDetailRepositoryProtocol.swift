//
//  PropertyDetailRepositoryProtocol.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Domain-layer contract for property detail data access.
public protocol PropertyDetailRepositoryProtocol: Sendable {
    /// Fetches full detail for a specific property.
    func fetchPropertyDetail(id: UUID) async throws -> Property?
}
