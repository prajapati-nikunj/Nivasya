//
//  FavoritesView.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct FavoritesView: View {
    @State private var viewModel: FavoritesViewModel
    @Environment(\.colorScheme) private var colorScheme
    @Environment(AppRouter.self) private var router
    
    public init(viewModel: FavoritesViewModel? = nil) {
        _viewModel = State(wrappedValue: viewModel ?? FavoritesViewModel())
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Favourites")
                .font(AppTypography.largeTitle)
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal)
                .padding(.top, 20) // Notch safety
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                    .frame(maxWidth: .infinity)
                Spacer()
            } else if viewModel.favoriteProperties.isEmpty {
                Spacer()
                VStack(spacing: AppSpacing.sm) {
                    Image(systemName: "heart.slash")
                        .font(.largeTitle)
                        .foregroundColor(AppColors.textSecondary)
                    Text("No favourites yet")
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textSecondary)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: AppSpacing.md) {
                        ForEach(viewModel.favoriteProperties) { property in
                            PropertyCard(property: property)
                                .onTapGesture {
                                    triggerHaptic()
                                    router.navigate(to: .propertyDetail(property))
                                }
                                .padding(.horizontal)
                        }
                        
                        // Bottom Spacer for Floating TabBar
                        Spacer(minLength: 120)
                    }
                }
            }
        }
        .padding(.vertical)
        .background(Color.clear)
        .task {
            await viewModel.loadFavorites()
        }
    }
}
