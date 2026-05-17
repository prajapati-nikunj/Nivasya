//
//  NotificationsRepository.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public final class NotificationsRepository: NotificationsRepositoryProtocol {
    private var mockData = [
        NotificationItem(title: "Price Drop!", message: "The Glass Horizon Villa is now $500k cheaper. Check it out!", time: "2h ago", type: .priceDrop),
        NotificationItem(title: "New Villa Nearby", message: "A new luxury property just listed in Malibu.", time: "5h ago", type: .newProperty),
        NotificationItem(title: "Visit Reminder", message: "Your viewing for 'Azure Waterfront' is tomorrow at 10 AM.", time: "1d ago", type: .visitReminder)
    ]
    
    public init() {}
    
    public func fetchNotifications() async throws -> [NotificationItem] {
        try await Task.sleep(nanoseconds: 500_000_000)
        return mockData
    }
    
    public func markAllAsRead() async throws {
        mockData = mockData.map {
            var item = $0
            item.isRead = true
            return item
        }
    }
}
