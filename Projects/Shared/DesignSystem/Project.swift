//
//  Project.swift
//  SharedManifests
//
//  Created by 지연 on 9/21/24.
//

import DependencyPlugin
import ProjectDescriptionHelpers
import ProjectDescription

let targets: [Target] = [
    .shared(
        interface: .DesignSystem,
        factory: .init(
            dependencies: [
                .shared(implements: .ThirdPartyLib)
            ]
        )
    ),
    .shared(
        implements: .DesignSystem,
        factory: .init(
            dependencies: [
                .shared(interface: .DesignSystem)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.DesignSystem.rawValue,
    targets: targets,
    resourceSynthesizers: [
        .assets(),
        .fonts()
    ]
)
