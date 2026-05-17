//
//  SecureStorage.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import LocalAuthentication
import Security

public final class SecureStorage {
    public static let shared = SecureStorage()
    private let service = "com.Nivasya.SecureStorage"
    
    private init() {}
    
    /// Checks if Biometric Authentication is available on the device.
    public var isBiometricsAvailable: Bool {
        var error: NSError?
        let context = LAContext()
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    /// Performs Biometric Authentication (Face ID / Touch ID).
    public func authenticateUser() async -> Bool {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            do {
                return try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access secure data")
            } catch {
                StructuredLogger.shared.log("Biometric auth failed: \(error.localizedDescription)", level: .error)
                return false
            }
        }
        return false
    }
    
    /// Saves sensitive data to the Keychain.
    public func save(_ value: String, for key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary) // Remove existing item if any
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    /// Retrieves sensitive data from the Keychain.
    public func get(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
