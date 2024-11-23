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
        interface: .Chat,
        factory: .init(
            dependencies: [
                .domain
            ]
        )
    ),
    .feature(
        implements: .Chat,
        factory: .init(
            dependencies: [
                .feature(interface: .Chat)
            ],
            settings: Project.Environment.defaultSettings
        )
    ),
    .feature(
        example: .Chat,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            dependencies: [
                .feature(implements: .Chat)
            ],
            settings: Project.Environment.defaultSettings
        )
    )
]

let project = Project.makeModule(
    name: ModulePath.Feature.Chat.rawValue,
    targets: targets
)
