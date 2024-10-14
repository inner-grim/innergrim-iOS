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
        case Main
        case Stat
        case Profile
        case Onboarding

        public static let name: String = "Feature"
    }
}

public extension ModulePath {
    enum Domain: String, CaseIterable {
        case Auth
        case Chat

        public static let name: String = "Domain"
    }
}

public extension ModulePath {
    enum Core: String, CaseIterable {
        case LocalStorage
        case Network

        public static let name: String = "Core"
    }
}

public extension ModulePath {
    enum Shared: String, CaseIterable {
        case DesignSystem
        case ThirdPartyLib
        case Util

        public static let name: String = "Shared"
    }
}
