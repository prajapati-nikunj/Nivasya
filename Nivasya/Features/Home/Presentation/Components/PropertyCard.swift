//
//  PropertyCard.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct PropertyCard: View {
    let property: Property
    
    public init(property: Property) {
        self.property = property
    }
    
    public var body: some View {
        GlassCard(cornerRadius: 24) {
            VStack(alignment: .leading, spacing: 12) { // Reduced spacing
                // Image Container - Optimized height for better fit
                ZStack(alignment: .topTrailing) {
                    OptimizedImage(url: property.mainImageURL)
                        .frame(height: 240) // Reduced from 280
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(20)
                    
                    // Heart Button
                    Button(action: { triggerHaptic() }) {
                        Image(systemName: property.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(property.isFavorite ? .red : .white)
                            .padding(12)
                            .background(
                                Circle()
                                    .fill(Color.black.opacity(0.3))
                            )
                    }
                    .padding(12)
                }
                
                // Property Details - Optimized sizing to prevent overflow
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(property.title)
                                .font(.system(size: 18, weight: .bold)) // Reduced size
                                .foregroundColor(AppColors.textPrimary)
                                .lineLimit(1)
                            
                            Text(property.address)
                                .font(.system(size: 13)) // Reduced size
                                .foregroundColor(AppColors.textSecondary)
                                .lineLimit(1)
                        }
                        
                        Spacer()
                        
                        Text("$\(property.price.formatted())")
                            .font(.system(size: 20, weight: .bold)) // Reduced size
                            .foregroundColor(AppColors.primary)
                    }
                    
                    // Specs - Reduced horizontal spacing
                    HStack(spacing: 16) {
                        SpecItem(icon: "bed.double.fill", value: "\(property.bedrooms)", label: "Beds")
                        SpecItem(icon: "shower.fill", value: "\(property.bathrooms)", label: "Baths")
                        SpecItem(icon: "car.fill", value: "\(property.parking)", label: "Garage")
                        SpecItem(icon: "square.fill", value: "\(property.area)", label: "Sq Ft")
                    }
                    .padding(.top, 4)
                }
            }
            .padding(16)
        }
        // Removed .frame(maxHeight: 420) — let the card size naturally to avoid clipping on larger Dynamic Type
    }
}

private struct SpecItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(AppColors.primary)
            
            Text(value)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(AppColors.textSecondary)
        }
    }
}
