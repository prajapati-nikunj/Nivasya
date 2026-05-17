//
//  SearchViewModel.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import Observation

@Observable
@MainActor
public final class SearchViewModel {
    public var searchText: String = ""
    public private(set) var searchResults: [Property] = []
    public private(set) var isLoading = false
    
    private let searchPropertiesUseCase: SearchPropertiesUseCase
    
    public init(searchPropertiesUseCase: SearchPropertiesUseCase? = nil) {
        self.searchPropertiesUseCase = searchPropertiesUseCase ??
            SearchPropertiesUseCaseImpl(repository: SearchRepository(propertyRepository: PropertyRepository()))
    }
    
    public func performSearch() async {
        guard !searchText.isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        
        do {
            searchResults = try await searchPropertiesUseCase.execute(query: searchText)
        } catch {
            StructuredLogger.shared.log("Search failed: \(error.localizedDescription)", level: .error)
            searchResults = []
        }
        
        isLoading = false
    }
}
