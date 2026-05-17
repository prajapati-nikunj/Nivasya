//
//  ProfileRepositoryProtocol.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation

public protocol ProfileRepositoryProtocol: Sendable {
    func fetchProfile() async throws -> UserProfile
    func updateProfile(_ profile: UserProfile) async throws
}
