//
//  Project.swift
//  DomainManifests
//
//  Created by 지연 on 9/21/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .domain(
        interface: .Chat,
        factory: .init(
            dependencies: [
                .core
            ]
        )
    ),
    .domain(
        implements: .Chat,
        factory: .init(
            dependencies: [
                .domain(interface: .Chat)
            ]
        )
    ),
    .domain(
        testing: .Chat,
        factory: .init(
            dependencies: [
                .domain(interface: .Chat)
            ]
        )
    ),
    .domain(
        tests: .Chat,
        factory: .init(
            dependencies: [
                .domain(implements: .Chat),
                .domain(testing: .Chat)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Domain.Chat.rawValue,
    targets: targets
)
