//
//  Property.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public struct Property: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public let title: String
    public let address: String
    public let price: Decimal
    public let bedrooms: Int
    public let bathrooms: Int
    public let parking: Int
    public let area: Int
    public let mainImageURL: String // Changed to String for Asset/URL flexibility
    public let images: [String]      // Changed to String for Asset/URL flexibility
    public var isFavorite: Bool
    public let isAvailable: Bool
    public let category: PropertyCategory
    public let description: String
    
    public init(
        id: UUID = UUID(),
        title: String,
        address: String,
        price: Decimal,
        bedrooms: Int,
        bathrooms: Int,
        parking: Int,
        area: Int,
        mainImageURL: String,
        images: [String],
        isFavorite: Bool = false,
        isAvailable: Bool = true,
        category: PropertyCategory,
        description: String
    ) {
        self.id = id
        self.title = title
        self.address = address
        self.price = price
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.parking = parking
        self.area = area
        self.mainImageURL = mainImageURL
        self.images = images
        self.isFavorite = isFavorite
        self.isAvailable = isAvailable
        self.category = category
        self.description = description
    }
}

public enum PropertyCategory: String, CaseIterable, Codable, Sendable {
    case villa = "Villas"
    case apartment = "Apartments"
    case penthouse = "Penthouses"
    case beachfront = "Beachfront"
}
