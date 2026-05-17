//
//  FavoritesViewModel.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import Observation

@Observable
@MainActor
public final class FavoritesViewModel {
    public private(set) var favoriteProperties: [Property] = []
    public private(set) var isLoading = false
    
    private let fetchFavoritesUseCase: FetchFavoritesUseCase
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    
    public init(
        fetchFavoritesUseCase: FetchFavoritesUseCase? = nil,
        toggleFavoriteUseCase: ToggleFavoriteUseCase? = nil
    ) {
        let defaultRepo = FavoritesRepository()
        self.fetchFavoritesUseCase = fetchFavoritesUseCase ??
            FetchFavoritesUseCaseImpl(repository: defaultRepo)
        self.toggleFavoriteUseCase = toggleFavoriteUseCase ??
            ToggleFavoriteUseCaseImpl(repository: defaultRepo)
    }
    
    public func loadFavorites() async {
        isLoading = true
        do {
            favoriteProperties = try await fetchFavoritesUseCase.execute()
        } catch {
            StructuredLogger.shared.log("Failed to load favorites: \(error.localizedDescription)", level: .error)
        }
        isLoading = false
    }
    
    public func removeFavorite(_ property: Property) async {
        do {
            _ = try await toggleFavoriteUseCase.execute(property: property)
            await loadFavorites()
        } catch {
            StructuredLogger.shared.log("Failed to remove favorite: \(error.localizedDescription)", level: .error)
        }
    }
}
