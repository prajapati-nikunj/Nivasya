//
//  NivasyaApp.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

@main
struct NivasyaApp: App {
    @State private var container = AppContainer()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @Environment(\.colorScheme) private var colorScheme
    
    init() {
        // Initialize principal-level infrastructure
        MemoryManager.shared.setup()
        StructuredLogger.shared.log("Application initialized", level: .info)
    }
    
    var body: some Scene {
        WindowGroup {
            AppRootView(hasCompletedOnboarding: $hasCompletedOnboarding, container: container)
        }
    }
}

private struct AppRootView: View {
    @Binding var hasCompletedOnboarding: Bool
    let container: AppContainer
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            // Background Layering
            AppColors.backgroundGradient(colorScheme: colorScheme)
                .ignoresSafeArea()
            
            // Content Layer
            Group {
                if hasCompletedOnboarding {
                    ContentView()
                        .environment(container)
                        .environment(container.router)
                } else {
                    OnboardingView()
                        .environment(container.router)
                }
            }
        }
    }
}
