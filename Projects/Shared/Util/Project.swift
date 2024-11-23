//
//  Project.swift
//  SharedManifests
//
//  Created by 지연 on 9/21/24.
//

import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .shared(
        implements: .Util,
        factory: .init()
    )
]

let project: Project = .makeModule(
    name: ModulePath.Shared.Util.rawValue,
    targets: targets
)
