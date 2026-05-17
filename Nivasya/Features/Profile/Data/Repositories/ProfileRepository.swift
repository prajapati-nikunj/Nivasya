//
//  ProfileRepository.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public final class ProfileRepository: ProfileRepositoryProtocol {
    private var mockProfile = UserProfile(
        name: "Nikunj Prajapati",
        avatarURL: "https://i.pravatar.cc/150?u=nikunj",
        memberType: "Premium Member",
        savedCount: 12,
        visitsCount: 4,
        contactedCount: 8,
        notificationsEnabled: true,
        biometricAuthEnabled: false
    )
    
    public init() {}
    
    public func fetchProfile() async throws -> UserProfile {
        try await Task.sleep(nanoseconds: 500_000_000)
        return mockProfile
    }
    
    public func updateProfile(_ profile: UserProfile) async throws {
        try await Task.sleep(nanoseconds: 300_000_000)
        mockProfile = profile
    }
}
