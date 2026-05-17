//
//  HapticService.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import UIKit

/// Centralized haptic feedback utility.
/// Extracted from the View extension so it can be used from any context,
/// not just SwiftUI View bodies.
public enum HapticService {
    /// Triggers impact haptic feedback with the specified intensity.
    public static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    /// Triggers a selection-changed haptic for picker-style interactions.
    public static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    /// Triggers a notification haptic for success, warning, or error events.
    public static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}
