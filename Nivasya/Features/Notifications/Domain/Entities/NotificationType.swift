//
//  NotificationType.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import SwiftUI

public enum NotificationType: Sendable {
    case priceDrop
    case newProperty
    case visitReminder
    
    public var iconName: String {
        switch self {
        case .priceDrop: return "arrow.down.circle.fill"
        case .newProperty: return "house.fill"
        case .visitReminder: return "calendar.badge.clock"
        }
    }
    
    public var themeColor: Color {
        switch self {
        case .priceDrop: return .green
        case .newProperty: return AppColors.primary
        case .visitReminder: return .orange
        }
    }
}
