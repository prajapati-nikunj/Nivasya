//
//  GlassCard.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct GlassCard<Content: View>: View {
    let content: Content
    let cornerRadius: CGFloat
    @Environment(\.colorScheme) private var colorScheme
    
    public init(cornerRadius: CGFloat = 24, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content()
    }
    
    public var body: some View {
        content
            // Removed fixed internal padding - children now control their own spacing
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                    
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(colorScheme == .dark ? Color.black.opacity(0.2) : Color.white.opacity(0.3))
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(colorScheme == .dark ? Color.white.opacity(0.1) : Color.white.opacity(0.5), lineWidth: 0.5)
            )
            .shadow(color: colorScheme == .dark ? .black.opacity(0.4) : .black.opacity(0.08), radius: 12, x: 0, y: 4)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

// MARK: - View Extension
extension View {
    public func glassCard(cornerRadius: CGFloat = 24) -> some View {
        GlassCard(cornerRadius: cornerRadius) {
            self.padding(16) // Default padding for extension usage
        }
    }
}
