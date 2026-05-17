//
//  HomeView.swift
//  Nivasya
//

import SwiftUI

public struct HomeView: View {
    @State private var viewModel: HomeViewModel
    @Environment(AppRouter.self) private var router
    @Environment(AppContainer.self) private var container
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var searchText = ""
    @State private var isShowingNotifications = false
    @State private var isShowingFilters = false
    @State private var nearbyProperties: [Property] = []
    
    public init(viewModel: HomeViewModel? = nil) {
        _viewModel = State(wrappedValue: viewModel ?? HomeViewModel())
    }
    
    public var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        AppHeaderOrganism(onNotificationTap: {
                            triggerHaptic()
                            isShowingNotifications = true
                        })
                        .padding(.horizontal, 16)
                        
                        SearchFilterTrayOrganism(
                            searchText: $searchText,
                            selectedCategory: $viewModel.selectedCategory,
                            onFilterTap: {
                                triggerHaptic()
                                isShowingFilters = true
                            }
                        )
                        .padding(.horizontal, 16)
                        
                        if viewModel.isLoading {
                            VStack(spacing: 20) {
                                ProgressView()
                                    .controlSize(.large)
                                    .padding(.top, 100)
                                Text("Discovering your dream home...")
                                    .font(AppTypography.body)
                                    .foregroundColor(AppColors.textSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        } else {
                            if !viewModel.featuredProperties.isEmpty {
                                VStack(alignment: .leading, spacing: 32) {
                                    PropertyCarouselOrganism(
                                        properties: nearbyProperties,
                                        onPropertyTap: navigateToProperty
                                    )
                                    
                                    PropertyListOrganism(
                                        properties: viewModel.featuredProperties,
                                        onPropertyTap: navigateToProperty,
                                        onViewAllTap: { triggerHaptic() }
                                    )
                                }
                                .transition(.opacity)
                            } else {
                                EmptyStateMolecule(message: "No properties found in this category")
                                    .padding(.horizontal, 16)
                                    .transition(.opacity)
                            }
                        }
                    }
                    // Strict bounding enforces stable layout for child components
                    .frame(width: geometry.size.width)
                    .padding(.top, 10)
                    .padding(.bottom, 90)
                }
            }
        }
        .sheet(isPresented: $isShowingNotifications) {
            NotificationsView(viewModel: container.makeNotificationsViewModel())
        }
        .sheet(isPresented: $isShowingFilters) {
            FilterView()
        }
        .task {
            if viewModel.featuredProperties.isEmpty {
                await viewModel.loadData()
            }
        }
        .onChange(of: viewModel.featuredProperties) { _, newValue in
            if nearbyProperties.isEmpty || nearbyProperties.count != newValue.count {
                nearbyProperties = newValue.shuffled()
            }
        }
    }
    
    private func navigateToProperty(_ property: Property) {
        triggerHaptic()
        router.navigate(to: .propertyDetail(property))
    }
}

#Preview("Home Screen") {
    HomeView()
        .environment(AppRouter())
        .environment(AppContainer())
}
