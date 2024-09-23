//
//  Project.swift
//  FeatureManifests
//
//  Created by 지연 on 9/21/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let featureTargets: [Target] = [
    .feature(
        factory: .init(
            dependencies: [
                .domain,
                .feature(implements: .Main),
                .feature(implements: .Onboarding),
                .feature(implements: .Profile),
                .feature(implements: .Stat)
            ]
        )
    )
]

let featurProject: Project = .makeModule(
    name: ModulePath.Feature.name,
    targets: featureTargets
)
