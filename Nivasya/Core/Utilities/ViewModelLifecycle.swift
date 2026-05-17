// File: Core/Utilities/ViewModelLifecycle.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation

/// Protocol to manage the lifecycle of ViewModels and prevent memory leaks.
public protocol ViewModelLifecycle: AnyObject {
    func onAppear()
    func onDisappear()
    func cleanup()
}

extension ViewModelLifecycle {
    public func onAppear() {}
    public func onDisappear() {}
    public func cleanup() {}
}
