//
//  SearchView.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct SearchView: View {
    @State private var viewModel: SearchViewModel
    @State private var isShowingFilters = false
    @Environment(\.colorScheme) private var colorScheme
    @Environment(AppRouter.self) private var router
    
    public init(viewModel: SearchViewModel? = nil) {
        _viewModel = State(wrappedValue: viewModel ?? SearchViewModel())
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Custom Search Bar
            HStack(spacing: AppSpacing.sm) {
                searchBar
                
                Button(action: { 
                    triggerHaptic()
                    isShowingFilters = true 
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(AppColors.primary)
                        .cornerRadius(12)
                }
            }
            .padding(.top, 20) // Notch safety
            .padding(.horizontal)
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else if viewModel.searchResults.isEmpty && !viewModel.searchText.isEmpty {
                Spacer()
                Text("No properties found")
                    .foregroundColor(AppColors.textSecondary)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: AppSpacing.md) {
                        ForEach(viewModel.searchResults) { property in
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
                    .padding(.vertical)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
        .sheet(isPresented: $isShowingFilters) {
            FilterView()
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.textSecondary)
            
            TextField("Search location...", text: $viewModel.searchText)
                .font(AppTypography.body)
                .onChange(of: viewModel.searchText) { _, _ in
                    Task { await viewModel.performSearch() }
                }
            
            if !viewModel.searchText.isEmpty {
                Button(action: { viewModel.searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(AppColors.textSecondary)
                }
            }
        }
        .padding(12)
        .background(AppColors.glassBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.glassBackground.opacity(0.3), lineWidth: 0.5)
        )
    }
}
