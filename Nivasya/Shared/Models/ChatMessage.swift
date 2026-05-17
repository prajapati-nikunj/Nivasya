// File: Shared/Models/ChatMessage.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation

public struct ChatMessage: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public let text: String
    public let senderID: String
    public let timestamp: Date
    public let isFromUser: Bool
    
    public init(id: UUID = UUID(), text: String, senderID: String, timestamp: Date = Date(), isFromUser: Bool) {
        self.id = id
        self.text = text
        self.senderID = senderID
        self.timestamp = timestamp
        self.isFromUser = isFromUser
    }
}
