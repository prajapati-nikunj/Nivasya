//
//  FilterView.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @State private var priceRange: ClosedRange<Double> = 500_000...5_000_000
    @State private var selectedPropertyType: PropertyCategory?
    @State private var selectedAmenities: Set<String> = []
    
    let amenities = ["Pool", "Gym", "Parking", "Garden", "Wi-Fi", "Security"]
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    // Price Range
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Price Range")
                            .font(AppTypography.headline)
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("$\(Int(priceRange.lowerBound).formatted()) - $\(Int(priceRange.upperBound).formatted())")
                            .font(AppTypography.title2)
                            .foregroundColor(AppColors.primary)
                        
                        Slider(value: Binding(get: { priceRange.upperBound }, set: { priceRange = priceRange.lowerBound...$0 }), in: 500_000...10_000_000, step: 50_000)
                            .tint(AppColors.primary)
                    }
                    
                    // Property Type
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Property Type")
                            .font(AppTypography.headline)
                            .foregroundColor(AppColors.textPrimary)
                        
                        FlowLayout(spacing: AppSpacing.xs) {
                            ForEach(PropertyCategory.allCases, id: \.self) { type in
                                FilterChip(title: type.rawValue, isSelected: selectedPropertyType == type) {
                                    selectedPropertyType = type
                                }
                            }
                        }
                    }
                    
                    // Amenities
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Amenities")
                            .font(AppTypography.headline)
                            .foregroundColor(AppColors.textPrimary)
                        
                        FlowLayout(spacing: AppSpacing.xs) {
                            ForEach(amenities, id: \.self) { amenity in
                                FilterChip(title: amenity, isSelected: selectedAmenities.contains(amenity)) {
                                    if selectedAmenities.contains(amenity) {
                                        selectedAmenities.remove(amenity)
                                    } else {
                                        selectedAmenities.insert(amenity)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .background(AppColors.background.ignoresSafeArea())
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") {
                        selectedPropertyType = nil
                        selectedAmenities.removeAll()
                        priceRange = 500_000...5_000_000
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.primary)
                }
            }
        }
    }
}

struct FilterChip: View {
    @Environment(\.colorScheme) private var colorScheme
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(AppTypography.caption)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? AppColors.primary : AppColors.glassBackground)
                .foregroundColor(isSelected ? .white : AppColors.textPrimary)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppColors.glassBackground.opacity(0.3), lineWidth: isSelected ? 0 : 0.5)
                )
        }
    }
}

struct FlowLayout: View {
    let spacing: CGFloat
    let content: [AnyView]
    
    init(spacing: CGFloat = 8, @ViewBuilder content: () -> some View) {
        self.spacing = spacing
        self.content = [AnyView(content())]
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], alignment: .leading, spacing: spacing) {
            ForEach(0..<content.count, id: \.self) { index in
                content[index]
            }
        }
    }
}
