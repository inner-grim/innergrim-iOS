//
//  ModulePath.swift
//  DependencyPlugin
//
//  Created by 지연 on 9/21/24.
//

import Foundation
import ProjectDescription

public enum ModulePath {
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
}

public extension ModulePath {
    enum App: String, CaseIterable {
        case iOS

        public static let name: String = "App"
    }
}

public extension ModulePath {
    enum Feature: String, CaseIterable {
        case main
        case onboarding

        public static let name: String = "Feature"
    }
}

public extension ModulePath {
    enum Domain: String, CaseIterable {
        case chat

        public static let name: String = "Domain"
    }
}

public extension ModulePath {
    enum Core: String, CaseIterable {
        case localStorage
        case network

        public static let name: String = "Core"
    }
}

public extension ModulePath {
    enum Shared: String, CaseIterable {
        case designSystem
        case thirdPartyLib
        case util

        public static let name: String = "Shared"
    }
}
