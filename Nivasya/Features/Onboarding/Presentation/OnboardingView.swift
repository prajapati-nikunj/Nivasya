//
//  OnboardingView.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct OnboardingView: View {
    @Environment(AppRouter.self) private var router
    @State private var isAnimating = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Background Image (Luxury Real Estate)
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&q=80&w=2000")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.black
            }
            .ignoresSafeArea()
            .overlay(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            VStack(spacing: DSSpacing.lg) {
                Spacer()
                
                // Brand Section
                VStack(alignment: .leading, spacing: DSSpacing.xs) {
                    Text("Nivasya")
                        .font(.system(size: 48, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                        .offset(y: isAnimating ? 0 : 20)
                        .opacity(isAnimating ? 1 : 0)
                    
                    Text("Where Dreams Find Address")
                        .font(DSTypography.subtitle)
                        .foregroundColor(.white.opacity(0.9))
                        .offset(y: isAnimating ? 0 : 20)
                        .opacity(isAnimating ? 1 : 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, DSSpacing.md)
                
                // Actions
                VStack(spacing: DSSpacing.md) {
                    DSButton("Get Started") {
                        triggerHaptic()
                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                    }
                    .offset(y: isAnimating ? 0 : 30)
                    .opacity(isAnimating ? 1 : 0)
                    
                    HStack(spacing: DSSpacing.md) {
                        SocialButton(systemName: "apple.logo")
                        SocialButton(systemName: "g.circle.fill")
                    }
                    .offset(y: isAnimating ? 0 : 30)
                    .opacity(isAnimating ? 1 : 0)
                }
                .padding(.horizontal, DSSpacing.md)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimating = true
            }
        }
    }
}

struct SocialButton: View {
    let systemName: String
    
    var body: some View {
        Button(action: { triggerHaptic() }) {
            Image(systemName: systemName)
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(.ultraThinMaterial)
                .cornerRadius(DSRadius.card)
                .overlay(
                    RoundedRectangle(cornerRadius: DSRadius.card)
                        .stroke(.white.opacity(0.2), lineWidth: 0.5)
                )
        }
        .accessibleButton()
    }
}
