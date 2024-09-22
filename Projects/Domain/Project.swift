//
//  Project.swift
//  DomainManifests
//
//  Created by 지연 on 9/21/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let domainTargets: [Target] = [
    .domain(
        factory: .init(
            dependencies: [
                .core,
                .domain(implements: .Chat)
            ]
        )
    )
]

let domainProject: Project = .makeModule(
    name: ModulePath.Domain.name,
    targets: domainTargets
)
