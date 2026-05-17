//
//  DSTypography.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public enum AppTypography {
    public static let largeTitle = Font.system(size: 34, weight: .bold)
    public static let title1 = Font.system(size: 28, weight: .bold)
    public static let title2 = Font.system(size: 22, weight: .semibold)
    public static let headline = Font.system(size: 18, weight: .semibold)
    public static let body = Font.system(size: 16, weight: .regular)
    public static let caption = Font.system(size: 13, weight: .medium)
    
    // Compatibility Mappings
    public static let largeDisplay = largeTitle
    public static let title = title1
    public static let subtitle = title2
    public static let price = title2
}

public enum AppRadius {
    public static let small: CGFloat = 12
    public static let medium: CGFloat = 20
    public static let large: CGFloat = 28
    public static let extraLarge: CGFloat = 36
    
    // Compatibility Mappings
    public static let card = large
}

public enum AppSpacing {
    public static let xs: CGFloat = 4
    public static let sm: CGFloat = 8
    public static let md: CGFloat = 16
    public static let lg: CGFloat = 24
    public static let xl: CGFloat = 32
    public static let xxl: CGFloat = 40
}

// Aliasing for compatibility
public typealias DSTypography = AppTypography
public typealias DSSpacing = AppSpacing
public typealias DSRadius = AppRadius

// MARK: - Shadow System
extension View {
    public func softShadow() -> some View {
        self.shadow(
            color: Color.black.opacity(0.28),
            radius: 20,
            x: 0,
            y: 12
        )
    }
    
    public func luxuryGlow() -> some View {
        self.shadow(
            color: AppColors.primaryGold.opacity(0.35),
            radius: 18,
            x: 0,
            y: 8
        )
    }
    
    public func glassDepth() -> some View {
        self
            .shadow(
                color: Color.white.opacity(0.08),
                radius: 1,
                x: 0,
                y: -1
            )
            .shadow(
                color: Color.black.opacity(0.45),
                radius: 30,
                x: 0,
                y: 20
            )
    }
    
    // Legacy support
    public func dsShadow(_ shadow: DSShadow) -> some View {
        self.shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
    }
}

public struct DSShadow {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat
}

public enum DSShadows {
    public static let soft = DSShadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
    public static let medium = DSShadow(color: Color.black.opacity(0.12), radius: 16, x: 0, y: 4)
    public static let glass = DSShadow(color: Color.white.opacity(0.15), radius: 10, x: 0, y: -2)
}
