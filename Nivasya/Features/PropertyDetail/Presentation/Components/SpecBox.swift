//
//  SpecBox.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct SpecBox: View {
    let icon: String
    let value: String
    let label: String
    var unit: String? = nil
    
    public init(icon: String, value: String, label: String, unit: String? = nil) {
        self.icon = icon
        self.value = value
        self.label = label
        self.unit = unit
    }
    
    public var body: some View {
        VStack(spacing: AppSpacing.xs) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundColor(AppColors.primaryGold)
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
                
                if let unit = unit {
                    Text(unit)
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                }
            }
            
            Text(label)
                .font(AppTypography.caption)
                .foregroundColor(AppColors.textMuted)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.sm)
        .glassCard()
    }
}
