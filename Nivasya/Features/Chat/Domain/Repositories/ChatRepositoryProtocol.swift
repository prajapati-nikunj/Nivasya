//
//  ChatRepositoryProtocol.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Domain-layer contract for chat/messaging operations.
public protocol ChatRepositoryProtocol: Sendable {
    /// Sends a user message and returns the agent's response.
    func sendMessage(_ text: String) async throws -> ChatMessage
    
    /// Fetches the initial greeting message.
    func fetchGreeting() async throws -> ChatMessage
}
