//
//  NearbyPropertyCard.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct NearbyPropertyCard: View {
    let property: Property
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Property Image
            ZStack(alignment: .topTrailing) {
                OptimizedImage(url: property.mainImageURL)
                    .frame(width: 200, height: 220)
                    .clipped()
                    .cornerRadius(20)
                
                // Favorite Button
                Button(action: { triggerHaptic() }) {
                    Image(systemName: property.isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(property.isFavorite ? .red : .white)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color.black.opacity(0.3))
                        )
                }
                .padding(12)
            }
            
            // Property Info
            VStack(alignment: .leading, spacing: 4) {
                Text(property.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text(property.address)
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.textSecondary)
                
                Text("$\(property.price.formatted())")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
        }
        .frame(width: 200, alignment: .leading) // Explicit width to prevent horizontal overflow
        .clipped() // Contain any shadow bleed
    }
}
