//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 지연 on 10/15/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .domain(
        interface: .Auth,
        factory: .init(
            dependencies: [
                .core
            ]
        )
    ),
    .domain(
        implements: .Auth,
        factory: .init(
            dependencies: [
                .domain(interface: .Auth)
            ]
        )
    ),
    .domain(
        testing: .Auth,
        factory: .init(
            dependencies: [
                .domain(interface: .Auth)
            ]
        )
    ),
    .domain(
        tests: .Auth,
        factory: .init(
            dependencies: [
                .domain(implements: .Auth),
                .domain(testing: .Auth)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Domain.Auth.rawValue,
    targets: targets
)
