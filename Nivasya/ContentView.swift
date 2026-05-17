//
//  ContentView.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

struct ContentView: View {
    @Environment(AppRouter.self) private var router
    @Environment(AppContainer.self) private var container
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedTab: AppTab = .explore
    
    init() {
        // Customize Native TabBar Appearance for Glassmorphic Effect
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        // Standard system blur is usually better for "native" feel,
        // but we ensure it doesn't have a harsh solid background.
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        @Bindable var router = router
        
        TabView(selection: $selectedTab) {
            // Explore Tab
            NavigationStack(path: $router.path) {
                HomeView(viewModel: container.makeHomeViewModel())
                    .navigationDestination(for: AppRoute.self) { route in
                        destinationView(for: route)
                    }
            }
            .tabItem {
                Label(AppTab.explore.title, systemImage: AppTab.explore.iconName)
            }
            .tag(AppTab.explore)
            
            // Search Tab
            SearchView(viewModel: container.makeSearchViewModel())
                .tabItem {
                    Label(AppTab.search.title, systemImage: AppTab.search.iconName)
                }
                .tag(AppTab.search)
            
            // Favorites Tab
            FavoritesView(viewModel: container.makeFavoritesViewModel())
                .tabItem {
                    Label(AppTab.favorites.title, systemImage: AppTab.favorites.iconName)
                }
                .tag(AppTab.favorites)
            
            // Messages Tab
            ChatView(viewModel: container.makeChatViewModel())
                .tabItem {
                    Label(AppTab.messages.title, systemImage: AppTab.messages.iconName)
                }
                .tag(AppTab.messages)
            
            // Profile Tab
            ProfileView(viewModel: container.makeProfileViewModel())
                .tabItem {
                    Label(AppTab.profile.title, systemImage: AppTab.profile.iconName)
                }
                .tag(AppTab.profile)
        }
        .accentColor(AppColors.primary)
    }
    
    @ViewBuilder
    private func destinationView(for route: AppRoute) -> some View {
        switch route {
        case .home:
            HomeView(viewModel: container.makeHomeViewModel())
        case .propertyDetail(let property):
            PropertyDetailView(property: property) // Properly accepts property, uses fallback DI inside
        case .search:
            SearchView(viewModel: container.makeSearchViewModel())
        case .favorites:
            FavoritesView(viewModel: container.makeFavoritesViewModel())
        case .profile:
            ProfileView(viewModel: container.makeProfileViewModel())
        }
    }
}
