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
                .SPM.SnapKit,
                .SPM.KakaoSDKAuth,
                .SPM.KakaoSDKUser
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.ThirdPartyLib.rawValue,
    packages: [
        .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMajor(from: "2.11.0"))
    ],
    targets: targets
)
