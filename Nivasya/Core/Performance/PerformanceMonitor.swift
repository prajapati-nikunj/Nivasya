//
//  PerformanceMonitor.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import OSLog
import QuartzCore

public final class PerformanceMonitor {
    public static let shared = PerformanceMonitor()
    private let signposter = OSSignposter(subsystem: "com.Nivasya", category: "Performance")
    
    private init() {}
    
    /// Measures the duration of an operation and logs it if it exceeds a threshold.
    public func measure<T>(_ name: String, threshold: Double = 0.1, operation: () async throws -> T) async rethrows -> T {
        let signpostID = signposter.makeSignpostID()
        
        // Explicitly defining the StaticString to satisfy the compiler
        let intervalName: StaticString = "OperationPerformance"
        
        let state = signposter.beginInterval(intervalName, id: signpostID)
        
        let start = CACurrentMediaTime()
        defer {
            signposter.endInterval(intervalName, state)
            let duration = CACurrentMediaTime() - start
            if duration > threshold {
                StructuredLogger.shared.log("Slow operation detected: \(name) took \(String(format: "%.2f", duration * 1000))ms", level: .warning)
            }
        }
        
        return try await operation()
    }
}
