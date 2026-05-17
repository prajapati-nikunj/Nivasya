//
//  NotificationsView.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct NotificationsView: View {
    @State private var viewModel: NotificationsViewModel
    @Environment(\.dismiss) private var dismiss
    
    public init(viewModel: NotificationsViewModel? = nil) {
        _viewModel = State(wrappedValue: viewModel ?? NotificationsViewModel())
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.notifications.isEmpty {
                    Text("No notifications")
                        .foregroundColor(AppColors.textSecondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack(spacing: AppSpacing.md) {
                        ForEach(viewModel.notifications) { notification in
                            notificationRow(notification)
                        }
                    }
                    .padding()
                }
            }
            .background(AppColors.background.ignoresSafeArea())
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Mark as read") { 
                        triggerHaptic() 
                        Task { await viewModel.markAllAsRead() }
                    }
                }
            }
        }
        .task {
            await viewModel.loadNotifications()
        }
    }
    
    private func notificationRow(_ item: NotificationItem) -> some View {
        HStack(spacing: AppSpacing.md) {
            Image(systemName: item.type.iconName)
                .font(.title3)
                .foregroundColor(item.type.themeColor)
                .frame(width: 44, height: 44)
                .background(item.type.themeColor.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.title)
                        .font(AppTypography.headline)
                        .foregroundColor(AppColors.textPrimary)
                    Spacer()
                    Text(item.time)
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textMuted)
                }
                
                Text(item.message)
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(2)
            }
        }
        .padding()
        .glassCard()
    }
}
