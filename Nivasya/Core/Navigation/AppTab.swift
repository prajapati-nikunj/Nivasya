// File: Core/Navigation/AppTab.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation

public enum AppTab: String, CaseIterable, Hashable {
    case explore, search, favorites, messages, profile
    
    public var iconName: String {
        switch self {
        case .explore: return "house.fill"
        case .search: return "magnifyingglass"
        case .favorites: return "heart.fill"
        case .messages: return "message.fill"
        case .profile: return "person.fill"
        }
    }
    
    public var title: String {
        switch self {
        case .explore: return "Explore"
        case .search: return "Search"
        case .favorites: return "Favourites"
        case .messages: return "Messages"
        case .profile: return "Profile"
        }
    }
}
