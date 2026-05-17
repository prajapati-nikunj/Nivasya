// File: App/Application/MemoryManager.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation
import UIKit
import OSLog

public final class MemoryManager: NSObject {
    public static let shared = MemoryManager()
    private let logger = Logger(subsystem: "com.Nivasya", category: "Memory")
    
    private override init() {
        super.init()
    }
    
    public func setup() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemoryWarning),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    
    @objc private func handleMemoryWarning() {
        logger.warning("Low memory warning received. Purging caches...")
        
        // Purge image caches
        URLCache.shared.removeAllCachedResponses()
        
        // Notify the app to release non-essential resources
        NotificationCenter.default.post(name: .appMemoryWarning, object: nil)
    }
}

extension Notification.Name {
    public static let appMemoryWarning = Notification.Name("com.Nivasya.appMemoryWarning")
}
