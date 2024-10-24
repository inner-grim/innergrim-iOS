//
//  Project.swift
//  AppManifests
//
//  Created by 지연 on 9/21/24.
//

import EnvironmentPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let appTargets: [Target] = [
    .app(
        implements: .iOS,
        factory: .init(
            infoPlist: Project.Environment.appInfoPlist,
            entitlements: "innergrim.entitlements",
            dependencies: [
                .feature
            ],
            settings: Project.Environment.appSettings
        )
    )
]

let appProject: Project = .makeModule(
    name: Project.Environment.appName,
    targets: appTargets
)
