//
//  SearchRepositoryProtocol.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Domain-layer contract for property search operations.
public protocol SearchRepositoryProtocol: Sendable {
    /// Searches properties matching a query string against title and address.
    func searchProperties(query: String) async throws -> [Property]
}
