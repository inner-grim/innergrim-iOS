//
//  Project.swift
//  FeatureManifests
//
//  Created by 지연 on 11/23/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .feature(
        interface: .Calendar,
        factory: .init(
            dependencies: [
                .domain
            ]
        )
    ),
    .feature(
        implements: .Calendar,
        factory: .init(
            dependencies: [
                .feature(interface: .Calendar)
            ],
            settings: Project.Environment.defaultSettings
        )
    ),
    .feature(
        example: .Calendar,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            dependencies: [
                .feature(implements: .Calendar)
            ],
            settings: Project.Environment.defaultSettings
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Feature.Calendar.rawValue,
    targets: targets
)
