//
//  NotificationItem.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public struct NotificationItem: Identifiable, Sendable {
    public let id: UUID
    public let title: String
    public let message: String
    public let time: String
    public let type: NotificationType
    public var isRead: Bool
    
    public init(id: UUID = UUID(), title: String, message: String, time: String, type: NotificationType, isRead: Bool = false) {
        self.id = id
        self.title = title
        self.message = message
        self.time = time
        self.type = type
        self.isRead = isRead
    }
}
