//
//  FetchProfileUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public protocol FetchProfileUseCase: Sendable {
    func execute() async throws -> UserProfile
}

public final class FetchProfileUseCaseImpl: FetchProfileUseCase {
    private let repository: ProfileRepositoryProtocol
    
    public init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws -> UserProfile {
        try await repository.fetchProfile()
    }
}
