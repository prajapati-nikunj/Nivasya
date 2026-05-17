//
//  FetchNotificationsUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public protocol FetchNotificationsUseCase: Sendable {
    func execute() async throws -> [NotificationItem]
}

public final class FetchNotificationsUseCaseImpl: FetchNotificationsUseCase {
    private let repository: NotificationsRepositoryProtocol
    
    public init(repository: NotificationsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws -> [NotificationItem] {
        try await repository.fetchNotifications()
    }
}
