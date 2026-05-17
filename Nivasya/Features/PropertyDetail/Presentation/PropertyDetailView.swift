//
//  PropertyDetailView.swift
//  Nivasya
//

import SwiftUI

public struct PropertyDetailView: View {
    @State private var viewModel: PropertyDetailViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @State private var isDescriptionExpanded = false
    @State private var scrollOffset: CGFloat = 0
    
    public init(property: Property) {
        _viewModel = State(wrappedValue: PropertyDetailViewModel(property: property))
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .bottom) {
                AppColors.background
                    .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                // Scroll tracker
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: proxy.frame(in: .named("detailScroll")).minY
                    )
                }
                .frame(height: 0)
                
                VStack(alignment: .leading, spacing: 0) {
                    // Image header — edge-to-edge
                    imageHeader
                    
                    // Text content — with horizontal padding
                    VStack(alignment: .leading, spacing: 24) {
                        titleAndPriceSection
                        specsGrid
                        descriptionSection
                        agentSection
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 140)
                }
                .containerRelativeFrame(.horizontal, alignment: .leading)
            }
            .coordinateSpace(name: "detailScroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                scrollOffset = value
            }
            .ignoresSafeArea(edges: .top)
            .clipped()
            
                // Bottom CTA — fixed at bottom, does NOT expand to fill the ZStack
                bottomCTA
            }
            .ignoresSafeArea(edges: .top)
            
            // Custom Floating Back Button
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .padding(10)
                        .background(
                            Circle()
                                .fill(.ultraThinMaterial)
                        )
                        .foregroundColor(AppColors.textPrimary)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            // Padding added safely below the notch because ZStack(alignment: .top) respects the safe area.
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar) // Keep nav bar clear to show image
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.property.title)
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
                    .opacity(scrollOffset < -250 ? 1 : 0)
                    .animation(.easeInOut(duration: 0.2), value: scrollOffset < -250)
            }
        }
    }
    
    private var imageHeader: some View {
        ZStack(alignment: .bottomTrailing) {
            // Using standard SwiftUI Image/AsyncImage instead of OptimizedImage
            Group {
                if viewModel.property.mainImageURL.hasPrefix("http") {
                    AsyncImage(url: URL(string: viewModel.property.mainImageURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle().fill(Color.gray.opacity(0.1))
                    }
                } else {
                    Image(viewModel.property.mainImageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            .clipped()
            
            // Image Gallery Indicator
            if viewModel.property.images.count > 0 {
                HStack(spacing: 8) {
                    Image(systemName: "photo.on.rectangle")
                        .font(.system(size: 12, weight: .semibold))
                    Text("1/\(viewModel.property.images.count)")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(.ultraThinMaterial)
                )
                .padding(16)
            }
        }
    }
    
    private var titleAndPriceSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.property.title)
                    .font(AppTypography.title1)
                    .foregroundColor(AppColors.textPrimary)
                
                Text(viewModel.property.address)
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            Spacer()
            
            Text("$\(viewModel.property.price.formatted())")
                .font(AppTypography.title2)
                .foregroundColor(AppColors.primary)
        }
    }
    
    private var specsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            SpecBox(icon: "square.fill", value: "\(viewModel.property.area)", label: "Area", unit: "sqft")
            SpecBox(icon: "bed.double.fill", value: "\(viewModel.property.bedrooms)", label: "Beds")
            SpecBox(icon: "shower.fill", value: "\(viewModel.property.bathrooms)", label: "Baths")
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Description")
                .font(AppTypography.title2)
                .foregroundColor(AppColors.textPrimary)
            
            Text(viewModel.property.description)
                .font(AppTypography.body)
                .foregroundColor(AppColors.textPrimary)
                .lineLimit(isDescriptionExpanded ? nil : 3)
            
            Button(isDescriptionExpanded ? "Read Less" : "Read More") {
                withAnimation(.spring()) { isDescriptionExpanded.toggle() }
            }
            .font(AppTypography.caption)
            .foregroundColor(AppColors.primary)
        }
    }
    
    private var agentSection: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: "https://i.pravatar.cc/150?u=agent")) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle().fill(Color.gray.opacity(0.1))
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Jane Cooper")
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
                Text("Luxury Specialist")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                actionIconButton(icon: "phone.fill")
                actionIconButton(icon: "message.fill")
            }
        }
        .padding(16)
        .glassCard()
    }
    
    private func actionIconButton(icon: String) -> some View {
        Button(action: { triggerHaptic() }) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .padding(12)
                .background(AppColors.primary)
                .clipShape(Circle())
        }
    }
    
    private var bottomCTA: some View {
        VStack(spacing: 0) {
            DSButton("Book a Visit") {
                triggerHaptic(.medium)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(
                colors: [
                    AppColors.background.opacity(0),
                    AppColors.background.opacity(0.9),
                    AppColors.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview("Property Detail") {
    PropertyDetailView(property: .mock)
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
