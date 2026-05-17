//
//  PropertyRepository.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Concrete repository implementation — reads from local MockData.json bundle.
/// In production, this would delegate to an APIClient for remote fetching
/// with a cache-first strategy using NSCache or CoreData.
public final class PropertyRepository: PropertyRepositoryProtocol {
    private let bundle: Bundle
    private let decoder: JSONDecoder
    
    /// Cached properties to avoid redundant disk reads.
    private var cachedProperties: [Property]?
    
    public init(bundle: Bundle = .main) {
        self.bundle = bundle
        self.decoder = JSONDecoder()
    }
    
    public func fetchAllProperties() async throws -> [Property] {
        if let cached = cachedProperties {
            return cached
        }
        
        guard let url = bundle.url(forResource: "MockData", withExtension: "json") else {
            StructuredLogger.shared.log("MockData.json not found in bundle", level: .error)
            return []
        }
        
        let data = try Data(contentsOf: url)
        let properties = try decoder.decode([Property].self, from: data)
        cachedProperties = properties
        return properties
    }
    
    public func fetchProperty(by id: UUID) async throws -> Property? {
        let all = try await fetchAllProperties()
        return all.first { $0.id == id }
    }
    
    public func fetchProperties(for category: PropertyCategory) async throws -> [Property] {
        let all = try await fetchAllProperties()
        return all.filter { $0.category == category }
    }
}
