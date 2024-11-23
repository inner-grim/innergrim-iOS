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
        interface: .Profile,
        factory: .init(
            dependencies: [
                .domain
            ]
        )
    ),
    .feature(
        implements: .Profile,
        factory: .init(
            dependencies: [
                .feature(interface: .Profile)
            ],
            settings: Project.Environment.defaultSettings
        )
    ),
    .feature(
        example: .Profile,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            dependencies: [
                .feature(implements: .Profile)
            ],
            settings: Project.Environment.defaultSettings
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Feature.Profile.rawValue,
    targets: targets
)
