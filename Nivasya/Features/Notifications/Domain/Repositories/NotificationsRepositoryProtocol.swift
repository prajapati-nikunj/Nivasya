//
//  NotificationsRepositoryProtocol.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public protocol NotificationsRepositoryProtocol: Sendable {
    func fetchNotifications() async throws -> [NotificationItem]
    func markAllAsRead() async throws
}
