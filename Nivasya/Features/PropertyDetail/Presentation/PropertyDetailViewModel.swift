// File: Features/PropertyDetail/Presentation/PropertyDetailViewModel.swift
//  Nivasya
//
//  Created by Nikunj Prajapati

import Foundation
import Observation

@Observable
@MainActor
public final class PropertyDetailViewModel {
    public let property: Property
    public private(set) var isLoading = false
    public private(set) var isFavorite = false
    public var selectedImageIndex = 0
    
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    
    public init(
        property: Property,
        toggleFavoriteUseCase: ToggleFavoriteUseCase? = nil
    ) {
        self.property = property
        self.isFavorite = property.isFavorite
        self.toggleFavoriteUseCase = toggleFavoriteUseCase ??
            ToggleFavoriteUseCaseImpl(repository: FavoritesRepository())
    }
    
    public func toggleFavorite() async {
        do {
            isFavorite = try await toggleFavoriteUseCase.execute(property: property)
        } catch {
            StructuredLogger.shared.log("Failed to toggle favorite: \(error.localizedDescription)", level: .error)
        }
    }
    
    public func loadDetails() async {
        isLoading = true
        // Simulate fetch — in production, would call FetchPropertyDetailUseCase
        try? await Task.sleep(nanoseconds: 500_000_000)
        isLoading = false
    }
}
