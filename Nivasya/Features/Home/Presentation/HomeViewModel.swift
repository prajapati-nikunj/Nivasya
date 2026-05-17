//
//  HomeViewModel.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import Observation

@Observable
@MainActor
public final class HomeViewModel {
    public private(set) var featuredProperties: [Property] = []
    public private(set) var isLoading = false
    public var selectedCategory: PropertyCategory? {
        didSet {
            Task { await filterProperties() }
        }
    }
    
    private let fetchPropertiesUseCase: FetchPropertiesUseCase
    private var allProperties: [Property] = []
    
    public init(fetchPropertiesUseCase: FetchPropertiesUseCase? = nil) {
        // Falls back to a default UseCase if none injected (for previews / backward compat)
        self.fetchPropertiesUseCase = fetchPropertiesUseCase ??
            FetchPropertiesUseCaseImpl(repository: PropertyRepository())
    }
    
    public func loadData() async {
        isLoading = true
        
        // Simulate realistic network delay
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        do {
            allProperties = try await fetchPropertiesUseCase.execute()
            featuredProperties = allProperties
        } catch {
            StructuredLogger.shared.log("Failed to load properties: \(error.localizedDescription)", level: .error)
            featuredProperties = []
        }
        
        isLoading = false
    }
    
    private func filterProperties() async {
        guard let category = selectedCategory else {
            featuredProperties = allProperties
            return
        }
        
        do {
            featuredProperties = try await fetchPropertiesUseCase.execute(for: category)
        } catch {
            StructuredLogger.shared.log("Failed to filter properties: \(error.localizedDescription)", level: .error)
            featuredProperties = allProperties.filter { $0.category == category }
        }
    }
}
