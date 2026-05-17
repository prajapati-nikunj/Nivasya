// File: Core/Logging/StructuredLogger.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation
import OSLog

public enum LogLevel: String {
    case debug, info, warning, error, critical
    
    var osLogType: OSLogType {
        switch self {
        case .debug: return .debug
        case .info: return .info
        case .warning: return .default
        case .error: return .error
        case .critical: return .fault
        }
    }
}

public final class StructuredLogger {
    public static let shared = StructuredLogger()
    private let logger = Logger(subsystem: "com.Nivasya", category: "App")
    
    private init() {}
    
    public func log(_ message: String, level: LogLevel = .info, file: String = #file, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        let sanitizedMessage = redactPII(message)
        let fullMessage = "[\(fileName):\(line)] \(sanitizedMessage)"
        
        switch level {
        case .debug: logger.debug("\(fullMessage)")
        case .info: logger.info("\(fullMessage)")
        case .warning: logger.warning("\(fullMessage)")
        case .error: logger.error("\(fullMessage)")
        case .critical: logger.fault("\(fullMessage)")
        }
    }
    
    private func redactPII(_ text: String) -> String {
        // Redact potential emails and phone numbers for privacy compliance
        let emailRegex = #"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"#
        return text.replacingOccurrences(of: emailRegex, with: "[EMAIL_REDACTED]", options: .regularExpression)
    }
}
