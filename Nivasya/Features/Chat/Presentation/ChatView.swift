//
//  ChatView.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct ChatView: View {
    @State private var viewModel: ChatViewModel
    @Environment(\.colorScheme) private var colorScheme
    
    public init(viewModel: ChatViewModel? = nil) {
        _viewModel = State(wrappedValue: viewModel ?? ChatViewModel())
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Header
            header
            
            // Messages List
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: AppSpacing.md) {
                        ForEach(viewModel.messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                        
                        if viewModel.isTyping {
                            HStack {
                                Text("Agent is typing...")
                                    .font(AppTypography.caption)
                                    .foregroundColor(AppColors.textSecondary)
                                    .padding(.horizontal)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) { _, _ in
                    withAnimation {
                        proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                    }
                }
            }
            
            // Input Area
            inputArea
        }
        .background(Color.clear)
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Nivasya Support")
                    .font(AppTypography.headline)
                    .foregroundColor(AppColors.textPrimary)
                HStack(spacing: 4) {
                    Circle().fill(AppColors.success).frame(width: 8, height: 8)
                    Text("Online")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textSecondary)
                }
            }
            Spacer()
        }
        .padding()
        .background(AppColors.surface)
        .softShadow()
    }
    
    private var inputArea: some View {
        HStack(spacing: AppSpacing.sm) {
            TextField("Message...", text: $viewModel.newMessageText)
                .padding(12)
                .background(AppColors.glassBackground)
                .cornerRadius(20)
            
            Button(action: {
                Task { await viewModel.sendMessage() }
            }) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Circle().fill(AppColors.primary))
            }
            .disabled(viewModel.newMessageText.isEmpty)
        }
        .padding()
        .background(AppColors.surface)
    }
}

struct ChatBubble: View {
    let message: ChatMessage
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack {
            if message.isFromUser { Spacer() }
            
            Text(message.text)
                .font(AppTypography.body)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    message.isFromUser ? 
                    AppColors.primary : 
                    AppColors.glassBackground
                )
                .foregroundColor(message.isFromUser ? .white : AppColors.textPrimary)
                .cornerRadius(18)
                .softShadow()
            
            if !message.isFromUser { Spacer() }
        }
    }
}
