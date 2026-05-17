//
//  ProfileViewModel.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import Observation

@Observable
@MainActor
public final class ProfileViewModel {
    public var profile: UserProfile?
    public var isLoading = false
    
    private let fetchProfileUseCase: FetchProfileUseCase
    private let updateProfileUseCase: UpdateProfileUseCase
    
    public init(
        fetchProfileUseCase: FetchProfileUseCase? = nil,
        updateProfileUseCase: UpdateProfileUseCase? = nil
    ) {
        let repo = ProfileRepository()
        self.fetchProfileUseCase = fetchProfileUseCase ?? FetchProfileUseCaseImpl(repository: repo)
        self.updateProfileUseCase = updateProfileUseCase ?? UpdateProfileUseCaseImpl(repository: repo)
    }
    
    public func loadProfile() async {
        isLoading = true
        do {
            profile = try await fetchProfileUseCase.execute()
        } catch {
            StructuredLogger.shared.log("Failed to fetch profile", level: .error)
        }
        isLoading = false
    }
    
    public func updateNotifications(enabled: Bool) async {
        guard var currentProfile = profile else { return }
        currentProfile.notificationsEnabled = enabled
        await saveProfile(currentProfile)
    }
    
    public func updateBiometricAuth(enabled: Bool) async {
        guard var currentProfile = profile else { return }
        currentProfile.biometricAuthEnabled = enabled
        await saveProfile(currentProfile)
    }
    
    private func saveProfile(_ updatedProfile: UserProfile) async {
        do {
            try await updateProfileUseCase.execute(profile: updatedProfile)
            self.profile = updatedProfile
        } catch {
            StructuredLogger.shared.log("Failed to update profile", level: .error)
        }
    }
}
