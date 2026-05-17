//
//  AppRoute.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import SwiftUI
import Observation

public enum AppRoute: Hashable, Codable {
    case home
    case propertyDetail(Property)
    case search
    case favorites
    case profile
}

public protocol RouterProtocol: AnyObject {
    var path: [AppRoute] { get set }
    func navigate(to route: AppRoute)
    func pop()
    func popToRoot()
}

@Observable
public final class AppRouter: RouterProtocol {
    public var path: [AppRoute] = []
    
    public init() {}
    
    public func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    public func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    public func popToRoot() {
        path.removeAll()
    }
}
