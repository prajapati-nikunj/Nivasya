//
//  CategoryChips.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct CategoryChipsView: View {
    @Binding var selectedCategory: PropertyCategory?
    @Environment(\.colorScheme) private var colorScheme
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(PropertyCategory.allCases, id: \.self) { category in
                    CategoryChip(
                        title: category.rawValue,
                        isSelected: selectedCategory == category,
                        action: {
                            triggerHaptic()
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedCategory = selectedCategory == category ? nil : category
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: isSelected ? .bold : .medium))
                .foregroundColor(isSelected ? .white : AppColors.textPrimary)
                .padding(.horizontal, 22)
                .padding(.vertical, 12)
                .background(
                    ZStack {
                        if isSelected {
                            // Selected State: Premium Green Capsule
                            Capsule()
                                .fill(AppColors.luxuryGradient(colorScheme: colorScheme))
                                .shadow(color: AppColors.primary.opacity(0.4), radius: 8, x: 0, y: 4)
                        } else {
                            // Unselected State: Glass Capsule
                            Capsule()
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    Capsule()
                                        .fill(colorScheme == .dark ? Color.white.opacity(0.05) : Color.black.opacity(0.05))
                                )
                        }
                    }
                )
                .overlay(
                    Capsule()
                        .stroke(
                            isSelected ? Color.clear : colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.05),
                            lineWidth: 0.5
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
