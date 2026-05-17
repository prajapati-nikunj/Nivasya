//
//  ChatRepository.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

/// Mock implementation of ChatRepositoryProtocol.
/// In production, this would integrate with a WebSocket or REST API.
public final class ChatRepository: ChatRepositoryProtocol {
    
    public init() {}
    
    public func sendMessage(_ text: String) async throws -> ChatMessage {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        let response = generateResponse(to: text)
        return ChatMessage(
            text: response,
            senderID: "agent",
            isFromUser: false
        )
    }
    
    public func fetchGreeting() async throws -> ChatMessage {
        ChatMessage(
            text: "Hello! How can I help you find your dream home today?",
            senderID: "agent",
            isFromUser: false
        )
    }
    
    // MARK: - Private
    
    private func generateResponse(to input: String) -> String {
        let text = input.lowercased()
        if text.contains("price") {
            return "Our prices range from $500k to $10M+. Which range are you interested in?"
        }
        if text.contains("villa") {
            return "We have some stunning villas in Malibu. Would you like to see them?"
        }
        if text.contains("apartment") {
            return "Our luxury apartments feature modern amenities and prime locations."
        }
        if text.contains("penthouse") {
            return "Our penthouses offer panoramic skyline views. Shall I schedule a viewing?"
        }
        return "That's interesting! I can certainly look into that for you. Anything else?"
    }
}
