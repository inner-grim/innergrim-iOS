//
//  Project.swift
//  FeatureManifests
//
//  Created by 지연 on 9/22/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .feature(
        interface: .Stat,
        factory: .init(
            dependencies: [
                .domain
            ]
        )
    ),
    .feature(
        implements: .Stat,
        factory: .init(
            dependencies: [
                .feature(interface: .Stat)
            ],
            settings: Project.Environment.defaultSettings
        )
    ),
    .feature(
        example: .Stat,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            dependencies: [
                .feature(implements: .Stat)
            ],
            settings: Project.Environment.defaultSettings
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Feature.Stat.rawValue,
    targets: targets
)
