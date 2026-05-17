//
//  ProfileView.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI

public struct ProfileView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var viewModel: ProfileViewModel
    
    public init(viewModel: ProfileViewModel? = nil) {
        _viewModel = State(wrappedValue: viewModel ?? ProfileViewModel())
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.xl) {
                // Profile Header
                if let profile = viewModel.profile {
                    VStack(spacing: AppSpacing.sm) {
                        AsyncImage(url: URL(string: profile.avatarURL)) { image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Circle().fill(AppColors.surface)
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(AppColors.primary, lineWidth: 2))
                        
                        Text(profile.name)
                            .font(AppTypography.title2)
                            .foregroundStyle(AppColors.textPrimary)
                        
                        Text(profile.memberType)
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(AppColors.primary.opacity(0.1))
                            .cornerRadius(20)
                    }
                    
                    // Stats Row
                    HStack {
                        ProfileStat(label: "Saved", value: "\(profile.savedCount)")
                        Divider().background(AppColors.glassBorder).frame(height: 30)
                        ProfileStat(label: "Visits", value: "\(profile.visitsCount)")
                        Divider().background(AppColors.glassBorder).frame(height: 30)
                        ProfileStat(label: "Contacted", value: "\(profile.contactedCount)")
                    }
                    .padding()
                    .glassCard()
                    
                    // Settings List
                    VStack(spacing: AppSpacing.sm) {
                        ProfileRow(icon: "person.fill", title: "Edit Profile")
                        
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(AppColors.primary)
                                .frame(width: 24)
                            Toggle("Notifications", isOn: Binding(
                                get: { profile.notificationsEnabled },
                                set: { newValue in Task { await viewModel.updateNotifications(enabled: newValue) } }
                            ))
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textPrimary)
                        }
                        .padding()
                        .glassCard()
                        
                        HStack {
                            Image(systemName: "faceid")
                                .foregroundColor(AppColors.primary)
                                .frame(width: 24)
                            Toggle("Face ID Access", isOn: Binding(
                                get: { profile.biometricAuthEnabled },
                                set: { newValue in Task { await viewModel.updateBiometricAuth(enabled: newValue) } }
                            ))
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textPrimary)
                        }
                        .padding()
                        .glassCard()
                        
                        ProfileRow(icon: "questionmark.circle.fill", title: "Help & Support")
                    }
                    .padding(.horizontal)
                } else if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                DSButton("Sign Out") {
                    triggerHaptic(.medium)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 40)
            }
            .padding(.vertical, AppSpacing.xxl)
        }
        .background(Color.clear)
        .task {
            await viewModel.loadProfile()
        }
    }
}

struct ProfileStat: View {
    let label: String
    let value: String
    var body: some View {
        VStack(spacing: 4) {
            Text(value).font(AppTypography.headline).foregroundStyle(AppColors.textPrimary)
            Text(label).font(AppTypography.caption).foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: { 
            triggerHaptic()
            action?()
        }) {
            HStack(spacing: AppSpacing.md) {
                Image(systemName: icon)
                    .foregroundColor(AppColors.primary)
                    .frame(width: 24)
                
                Text(title)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(AppColors.textMuted)
            }
            .padding()
            .glassCard()
        }
    }
}
