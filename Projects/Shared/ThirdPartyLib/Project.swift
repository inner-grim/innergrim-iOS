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
        implements: .ThirdPartyLib,
        factory: .init(
            infoPlist: .extendingDefault(
                with: [
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "",
                    "LSSupportsOpeningDocumentsInPlace": true
                ]
            ),
            dependencies: [
                .SPM.SnapKit
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.ThirdPartyLib.rawValue,
    packages: [
        .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1"))
    ],
    targets: targets
)
