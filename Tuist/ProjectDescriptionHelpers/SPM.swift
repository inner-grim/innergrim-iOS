//
//  SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by 지연 on 9/21/24.
//

import ProjectDescription

extension TargetDependency {
    public struct SPM {}
}

public extension TargetDependency.SPM {
    static let SnapKit = Self.package(product: "SnapKit")
    static let KakaoSDKAuth = Self.package(product: "KakaoSDKAuth")
    static let KakaoSDKUser = Self.package(product: "KakaoSDKUser")

    private static func external(_ name: String) -> TargetDependency {
        return TargetDependency.external(name: name)
    }

    private static func package(product: String) -> TargetDependency {
        return TargetDependency.package(product: product)
    }
}
