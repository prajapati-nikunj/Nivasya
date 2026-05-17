//
//  MarkNotificationsReadUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public protocol MarkNotificationsReadUseCase: Sendable {
    func execute() async throws
}

public final class MarkNotificationsReadUseCaseImpl: MarkNotificationsReadUseCase {
    private let repository: NotificationsRepositoryProtocol
    
    public init(repository: NotificationsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws {
        try await repository.markAllAsRead()
    }
}
