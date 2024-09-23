//
//  Project.swift
//  CoreManifests
//
//  Created by 지연 on 9/21/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .core(
        interface: .LocalStorage,
        factory: .init(
            dependencies: [
                .shared
            ]
        )
    ),
    .core(
        implements: .LocalStorage,
        factory: .init(
            dependencies: [
                .core(interface: .LocalStorage)
            ]
        )
    ),
    .core(
        testing: .LocalStorage,
        factory: .init()
    ),
    .core(
        tests: .LocalStorage,
        factory: .init(
            dependencies: [
                .core(implements: .LocalStorage),
                .core(testing: .LocalStorage)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Core.LocalStorage.rawValue,
    targets: targets
)
