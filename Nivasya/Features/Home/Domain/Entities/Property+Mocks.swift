//
//  Property+Mocks.swift
//  Nivasya
//

import Foundation

extension Property {
    public static var mock: Property {
        Property(
            id: UUID(),
            title: "Glass Horizon Villa",
            address: "Malibu, California",
            price: 7500000,
            bedrooms: 5,
            bathrooms: 4,
            parking: 3,
            area: 4500,
            mainImageURL: "Home",
            images: ["Home", "Room", "Home1"],
            category: .villa,
            description: "A masterpiece of modern architecture featuring floor-to-ceiling glass walls and panoramic ocean views. This villa offers the ultimate luxury living experience."
        )
    }
    
    public static var mockList: [Property] {
        [
            mock,
            Property(
                id: UUID(),
                title: "The Amber Penthouse",
                address: "Manhattan, New York",
                price: 12000000,
                bedrooms: 4,
                bathrooms: 3,
                parking: 2,
                area: 3200,
                mainImageURL: "Home1",
                images: ["Home1", "Room"],
                category: .penthouse,
                description: "Experience the height of luxury in this stunning Manhattan penthouse."
            ),
            Property(
                id: UUID(),
                title: "Modernist Retreat",
                address: "Aspen, Colorado",
                price: 5200000,
                bedrooms: 3,
                bathrooms: 3,
                parking: 2,
                area: 2800,
                mainImageURL: "Room",
                images: ["Room", "Home"],
                category: .villa, // Corrected from .house to .villa
                description: "A cozy yet modern retreat in the heart of Aspen."
            )
        ]
    }
}
