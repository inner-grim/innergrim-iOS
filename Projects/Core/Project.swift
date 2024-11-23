//
//  Project.swift
//  CoreManifests
//
//  Created by 지연 on 9/21/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let coreTargets: [Target] = [
    .core(
        factory: .init(
            dependencies: [
                .shared,
                .core(implements: .Network),
                .core(implements: .LocalStorage)
            ]
        )
    )
]

let coreProject: Project = .makeModule(
    name: ModulePath.Core.name,
    targets: coreTargets
)
