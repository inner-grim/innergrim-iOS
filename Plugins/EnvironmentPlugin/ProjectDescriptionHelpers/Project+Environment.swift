//
//  Project+Environment.swift
//  EnvironmentPlugin
//
//  Created by 지연 on 9/21/24.
//

import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "innergrim"
        public static let deploymentTargets = DeploymentTargets.iOS("17.0")
        public static let bundleId = "com.innergrim.innergrim"
        public static let defaultSettings: Settings = .settings(
            base: [
                "ENABLE_USER_SCRIPT_SANDBOXING": "YES"
            ]
        )
        public static let appInfoPlist: InfoPlist = .extendingDefault(with: [
            "ITSAppUsesNonExemptEncryption": false,
            "CFBundleDisplayName": "이너그림",
            "CFBundleName": "innergrim",
            "CFBundleShortVersionString": "1.0.0",
            "CFBundleVersion": "1",
            "UILaunchStoryboardName": "LaunchScreen",
            "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
            "UIApplicationSceneManifest": [
                "UIApplicationSupportsMultipleScenes": false,
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": [[
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ]]
                ]
            ]
        ])
    }
}
