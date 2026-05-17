//
//  DSButton.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct PremiumButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity)
            .background(
                AppColors.luxuryGradient(colorScheme: colorScheme)
            )
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
            .shadow(
                color: AppColors.primary.opacity(0.35),
                radius: 20,
                y: 12
            )
    }
}

public struct DSButton: View {
    public enum Style {
        case primary
        case secondary
        case glass
    }
    
    private let title: String
    private let style: Style
    private let action: () -> Void
    
    public init(_ title: String, style: Style = .primary, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(PremiumButtonStyle())
    }
}

// MARK: - Supporting Views
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
