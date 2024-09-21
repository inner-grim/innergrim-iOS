import ProjectDescription

let project = Project(
    name: "innergrim",
    targets: [
        .target(
            name: "innergrim",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.innergrim.innergrim",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(
                with: [
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
                ]
            ),
            sources: ["innergrim/Sources/**"],
            resources: ["innergrim/Resources/**"],
            dependencies: []
        )
    ]
)
