//
//  SendMessageUseCase.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

// MARK: - Protocol

/// Use case contract for sending a chat message and receiving a response.
public protocol SendMessageUseCase: Sendable {
    /// Sends the user's message and returns the agent's response.
    func execute(text: String) async throws -> ChatMessage
}

// MARK: - Implementation

public final class SendMessageUseCaseImpl: SendMessageUseCase {
    private let repository: ChatRepositoryProtocol
    
    public init(repository: ChatRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(text: String) async throws -> ChatMessage {
        try await repository.sendMessage(text)
    }
}
