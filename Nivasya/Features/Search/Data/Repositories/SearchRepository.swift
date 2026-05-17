//
//  SearchRepository.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Data-layer implementation of search.
/// Leverages the shared PropertyRepository for the data source and performs
/// local filtering. In production, this would call a server-side search API.
public final class SearchRepository: SearchRepositoryProtocol {
    private let propertyRepository: PropertyRepositoryProtocol
    
    public init(propertyRepository: PropertyRepositoryProtocol) {
        self.propertyRepository = propertyRepository
    }
    
    public func searchProperties(query: String) async throws -> [Property] {
        let allProperties = try await propertyRepository.fetchAllProperties()
        let lowercasedQuery = query.lowercased()
        
        return allProperties.filter {
            $0.title.lowercased().contains(lowercasedQuery) ||
            $0.address.lowercased().contains(lowercasedQuery) ||
            $0.category.rawValue.lowercased().contains(lowercasedQuery)
        }
    }
}
