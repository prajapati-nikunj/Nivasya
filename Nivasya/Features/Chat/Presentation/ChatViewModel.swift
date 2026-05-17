//
//  ChatViewModel.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import Observation

@Observable
@MainActor
public final class ChatViewModel {
    public private(set) var messages: [ChatMessage] = []
    public var newMessageText: String = ""
    public var isTyping: Bool = false
    
    private let sendMessageUseCase: SendMessageUseCase
    private let chatRepository: ChatRepositoryProtocol // For fetching greeting
    
    public init(
        sendMessageUseCase: SendMessageUseCase? = nil,
        chatRepository: ChatRepositoryProtocol? = nil
    ) {
        let repo = chatRepository ?? ChatRepository()
        self.chatRepository = repo
        self.sendMessageUseCase = sendMessageUseCase ?? SendMessageUseCaseImpl(repository: repo)
        
        // Load initial greeting
        Task {
            if let greeting = try? await self.chatRepository.fetchGreeting() {
                self.messages.append(greeting)
            }
        }
    }
    
    public func sendMessage() async {
        guard !newMessageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let userText = newMessageText
        let userMessage = ChatMessage(text: userText, senderID: "user", isFromUser: true)
        
        messages.append(userMessage)
        newMessageText = ""
        isTyping = true
        
        do {
            let responseMessage = try await sendMessageUseCase.execute(text: userText)
            messages.append(responseMessage)
        } catch {
            StructuredLogger.shared.log("Failed to send message: \(error.localizedDescription)", level: .error)
            let errorMsg = ChatMessage(text: "Sorry, I'm having trouble connecting right now.", senderID: "system", isFromUser: false)
            messages.append(errorMsg)
        }
        
        isTyping = false
    }
}
