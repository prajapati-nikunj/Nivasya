//
//  NotificationsViewModel.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import Observation

@Observable
@MainActor
public final class NotificationsViewModel {
    public private(set) var notifications: [NotificationItem] = []
    public private(set) var isLoading = false
    
    private let fetchNotificationsUseCase: FetchNotificationsUseCase
    private let markNotificationsReadUseCase: MarkNotificationsReadUseCase
    
    public init(
        fetchNotificationsUseCase: FetchNotificationsUseCase? = nil,
        markNotificationsReadUseCase: MarkNotificationsReadUseCase? = nil
    ) {
        let repo = NotificationsRepository()
        self.fetchNotificationsUseCase = fetchNotificationsUseCase ?? FetchNotificationsUseCaseImpl(repository: repo)
        self.markNotificationsReadUseCase = markNotificationsReadUseCase ?? MarkNotificationsReadUseCaseImpl(repository: repo)
    }
    
    public func loadNotifications() async {
        isLoading = true
        do {
            notifications = try await fetchNotificationsUseCase.execute()
        } catch {
            StructuredLogger.shared.log("Failed to fetch notifications", level: .error)
        }
        isLoading = false
    }
    
    public func markAllAsRead() async {
        do {
            try await markNotificationsReadUseCase.execute()
            await loadNotifications()
        } catch {
            StructuredLogger.shared.log("Failed to mark notifications as read", level: .error)
        }
    }
}
