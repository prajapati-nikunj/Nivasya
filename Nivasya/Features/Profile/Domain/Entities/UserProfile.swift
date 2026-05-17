//
//  UserProfile.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public struct UserProfile: Identifiable, Sendable {
    public let id: UUID
    public var name: String
    public var avatarURL: String
    public var memberType: String
    public var savedCount: Int
    public var visitsCount: Int
    public var contactedCount: Int
    public var notificationsEnabled: Bool
    public var biometricAuthEnabled: Bool
    
    public init(
        id: UUID = UUID(),
        name: String,
        avatarURL: String,
        memberType: String,
        savedCount: Int = 0,
        visitsCount: Int = 0,
        contactedCount: Int = 0,
        notificationsEnabled: Bool = true,
        biometricAuthEnabled: Bool = false
    ) {
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
        self.memberType = memberType
        self.savedCount = savedCount
        self.visitsCount = visitsCount
        self.contactedCount = contactedCount
        self.notificationsEnabled = notificationsEnabled
        self.biometricAuthEnabled = biometricAuthEnabled
    }
}
