//
//  UpdateProfileUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public protocol UpdateProfileUseCase: Sendable {
    func execute(profile: UserProfile) async throws
}

public final class UpdateProfileUseCaseImpl: UpdateProfileUseCase {
    private let repository: ProfileRepositoryProtocol
    
    public init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(profile: UserProfile) async throws {
        try await repository.updateProfile(profile)
    }
}
