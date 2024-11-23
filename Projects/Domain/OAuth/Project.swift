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
        interface: .OAuth,
        factory: .init(
            dependencies: [
                .core
            ]
        )
    ),
    .domain(
        implements: .OAuth,
        factory: .init(
            dependencies: [
                .domain(interface: .OAuth)
            ]
        )
    ),
    .domain(
        testing: .OAuth,
        factory: .init(
            dependencies: [
                .domain(interface: .OAuth)
            ]
        )
    ),
    .domain(
        tests: .OAuth,
        factory: .init(
            dependencies: [
                .domain(implements: .OAuth),
                .domain(testing: .OAuth)
            ]
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Domain.OAuth.rawValue,
    targets: targets
)
