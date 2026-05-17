//
//  DSColors.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI
import UIKit

/// Premium Glassmorphic Design System with Dynamic Light/Dark support.
/// Refined for maximum contrast and depth as per high-fidelity standards.
public enum AppColors {
    // MARK: - Light Mode Colors
    public enum Light {
        public static let background = Color(hex: "#FAFAFA") // Slightly off-white for depth
        public static let surface = Color.white
        public static let glassBackground = Color.white.opacity(0.6) // Balanced transparency
        public static let glassStroke = Color.white.opacity(0.5)
        public static let primary = Color(hex: "#2D5A4A")
        public static let primaryLight = Color(hex: "#14B8A6")
        public static let accent = Color(hex: "#F59E0B")
        public static let textPrimary = Color(hex: "#1A1A1A") // Nearly black
        public static let textSecondary = Color(hex: "#4A4A4A") // Darker for light mode
        public static let textMuted = Color(hex: "#9CA3AF")
        public static let border = Color(hex: "#E0E0E0")
        public static let success = Color(hex: "#10B981")
    }
    
    // MARK: - Dark Mode Colors
    public enum Dark {
        public static let background = Color(hex: "#0A0A0A") // Darker black for depth
        public static let surface = Color(hex: "#1A1A1A")
        public static let glassBackground = Color.black.opacity(0.25) // Lower opacity for dark mode
        public static let glassStroke = Color.white.opacity(0.1)
        public static let primary = Color(hex: "#14B8A6")
        public static let primaryLight = Color(hex: "#2DD4BF")
        public static let accent = Color(hex: "#FBBF24")
        public static let textPrimary = Color.white.opacity(0.95) // Nearly white
        public static let textSecondary = Color.white.opacity(0.6) // Brighter for dark mode
        public static let textMuted = Color.white.opacity(0.3)
        public static let border = Color(hex: "#2D2D2D")
        public static let success = Color(hex: "#34D399")
    }
    
    // MARK: - Dynamic Core Tokens (Safe for usage without colorScheme)
    public static let primary = dynamicColor(light: Light.primary, dark: Dark.primary)
    public static let background = dynamicColor(light: Light.background, dark: Dark.background)
    public static let surface = dynamicColor(light: Light.surface, dark: Dark.surface)
    public static let textPrimary = dynamicColor(light: Light.textPrimary, dark: Dark.textPrimary)
    public static let textSecondary = dynamicColor(light: Light.textSecondary, dark: Dark.textSecondary)
    public static let textMuted = dynamicColor(light: Light.textMuted, dark: Dark.textMuted)
    public static let border = dynamicColor(light: Light.border, dark: Dark.border)
    public static let success = dynamicColor(light: Light.success, dark: Dark.success)
    public static let glassBackground = dynamicColor(light: Light.glassBackground, dark: Dark.glassBackground)
    public static let glassBorder = dynamicColor(light: Light.glassStroke, dark: Dark.glassStroke)
    
    // Legacy Aliases
    public static let white = textPrimary
    public static let primaryText = textPrimary
    public static let secondaryText = textSecondary
    public static let backgroundPrimary = background
    public static let backgroundElevated = surface
    public static let primaryGold = primary // Use refined primary instead of legacy gold
    
    // MARK: - Dynamic Functions (For Explicit Usage)
    public static func luxuryGradient(colorScheme: ColorScheme) -> LinearGradient {
        LinearGradient(
            colors: colorScheme == .dark ? 
                [Color(hex: "#14B8A6"), Color(hex: "#2DD4BF")] :
                [Color(hex: "#2D5A4A"), Color(hex: "#14B8A6")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    public static func backgroundGradient(colorScheme: ColorScheme) -> LinearGradient {
        colorScheme == .dark ? 
            LinearGradient(colors: [Dark.background, Dark.surface], startPoint: .top, endPoint: .bottom) :
            LinearGradient(colors: [Light.background, Color.white], startPoint: .top, endPoint: .bottom)
    }
    
    // MARK: - Helper for Dynamic Colors
    private static func dynamicColor(light: Color, dark: Color) -> Color {
        return Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}

public typealias DSColors = AppColors

// MARK: - Color Hex Extension
extension Color {
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}
