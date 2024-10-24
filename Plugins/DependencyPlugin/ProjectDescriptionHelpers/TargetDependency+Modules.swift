//
//  TargetDependency+Modules.swift
//  DependencyPlugin
//
//  Created by 지연 on 9/21/24.
//

import ProjectDescription

// MARK: - App

public extension TargetDependency {
    static var app: Self {
        return .project(target: ModulePath.App.name, path: .app)
    }

    static func app(implements module: ModulePath.App) -> Self {
        return .target(name: ModulePath.App.name + module.rawValue)
    }
}

// MARK: - Feature

public extension TargetDependency {
    static var feature: Self {
        return .project(target: ModulePath.Feature.name, path: .feature)
    }

    static func feature(implements module: ModulePath.Feature) -> Self {
        return .project(target: ModulePath.Feature.name + module.rawValue, path: .feature(implementation: module))
    }

    static func feature(interface module: ModulePath.Feature) -> Self {
        return .project(target: ModulePath.Feature.name + module.rawValue + "Interface", path: .feature(implementation: module))
    }
    
    static func feature(example module: ModulePath.Feature) -> Self {
        return .project(target: ModulePath.Feature.name + module.rawValue + "Example", path: .feature(implementation: module))
    }
}

// MARK: - Domain

public extension TargetDependency {
    static var domain: Self {
        return .project(target: ModulePath.Domain.name, path: .domain)
    }

    static func domain(implements module: ModulePath.Domain) -> Self {
        return .project(target: ModulePath.Domain.name + module.rawValue, path: .domain(implementation: module))
    }

    static func domain(interface module: ModulePath.Domain) -> Self {
        return .project(target: ModulePath.Domain.name + module.rawValue + "Interface", path: .domain(implementation: module))
    }
    
    static func domain(tests module: ModulePath.Domain) -> Self {
        return .project(target: ModulePath.Domain.name + module.rawValue + "Tests", path: .domain(implementation: module))
    }
    
    static func domain(testing module: ModulePath.Domain) -> Self {
        return .project(target: ModulePath.Domain.name + module.rawValue + "Testing", path: .domain(implementation: module))
    }
}

// MARK: - Core

public extension TargetDependency {
    static var core: Self {
        return .project(target: ModulePath.Core.name, path: .core)
    }

    static func core(implements module: ModulePath.Core) -> Self {
        return .project(target: ModulePath.Core.name + module.rawValue, path: .core(implementation: module))
    }

    static func core(interface module: ModulePath.Core) -> Self {
        return .project(target: ModulePath.Core.name + module.rawValue + "Interface", path: .core(implementation: module))
    }
    
    static func core(tests module: ModulePath.Core) -> Self {
        return .project(target: ModulePath.Core.name + module.rawValue + "Tests", path: .core(implementation: module))
    }
    
    static func core(testing module: ModulePath.Core) -> Self {
        return .project(target: ModulePath.Core.name + module.rawValue + "Testing", path: .core(implementation: module))
    }
}

// MARK: - Shared

public extension TargetDependency {
    static var shared: Self {
        return .project(target: ModulePath.Shared.name, path: .shared)
    }

    static func shared(implements module: ModulePath.Shared) -> Self {
        return .project(target: ModulePath.Shared.name + module.rawValue, path: .shared(implementation: module))
    }
    
    static func shared(interface module: ModulePath.Shared) -> Self {
        return .project(target: ModulePath.Shared.name + module.rawValue + "Interface", path: .shared(implementation: module))
    }
}
