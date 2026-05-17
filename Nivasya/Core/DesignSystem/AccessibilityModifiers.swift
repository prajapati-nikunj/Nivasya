// File: Core/DesignSystem/AccessibilityModifiers.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import SwiftUI

public struct AccessibleButtonModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    public func body(content: Content) -> some View {
        content
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isButton)
    }
}

extension View {
    public func accessibleButton() -> some View {
        self.modifier(AccessibleButtonModifier())
    }
    
    /// Haptic feedback helper — delegates to the centralized HapticService.
    public func triggerHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        HapticService.impact(style)
    }
}
