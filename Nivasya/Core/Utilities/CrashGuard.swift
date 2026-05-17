// File: Core/Utilities/CrashGuard.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation
import OSLog

public struct CrashGuard {
    private static let logger = Logger(subsystem: "com.Nivasya", category: "CrashGuard")
    
    /// Wraps any throwing call with automatic retry and fallback to prevent application crashes.
    @discardableResult
    public static func safely<T>(
        _ operation: @escaping () async throws -> T,
        fallback: T,
        retries: Int = 2
    ) async -> T {
        for attempt in 0...retries {
            do {
                return try await operation()
            } catch {
                logger.error("Attempt \(attempt) failed: \(error.localizedDescription)")
                if attempt < retries {
                    await Task.yield()
                    // Exponential backoff
                    try? await Task.sleep(nanoseconds: 500_000_000 * UInt64(attempt + 1))
                }
            }
        }
        logger.critical("Operation failed after \(retries) retries. Using fallback.")
        return fallback
    }
}
