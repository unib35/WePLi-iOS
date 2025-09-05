import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "WePLi",
    organizationName: "com.wepli",
    settings: Settings.settings(
        base: [:],
        configurations: [
            .debug(name: "Debug-Dev", xcconfig: "../../Configs/Dev.xcconfig"),
            .debug(name: "Debug-Staging", xcconfig: "../../Configs/Staging.xcconfig"),
            .release(name: "Release-Prod", xcconfig: "../../Configs/Prod.xcconfig")
        ]
    ),
    targets: [
        Target(
            name: "WePLi",
            platform: .iOS,
            product: .app,
            bundleId: "com.wepli.app",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:],
                "CFBundleDisplayName": "WePLi",
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": true,
                    "UISceneConfigurations": [:]
                ],
                "UIUserInterfaceStyle": "Light",
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                "UIRequiresFullScreen": true
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [
                .pre(
                    path: "../../Scripts/swiftlint.sh",
                    arguments: [],
                    name: "SwiftLint",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                // Core Modules
                .project(target: "WePLiCore", path: "../Core/WePLiCore"),
                .project(target: "WePLiKit", path: "../Core/WePLiKit"),
                .project(target: "WePLiResource", path: "../Core/WePLiResource"),
                
                // Feature Modules
                .project(target: "WePLiAuth", path: "../Features/WePLiAuth"),
                .project(target: "WePLiCommunity", path: "../Features/WePLiCommunity"),
                .project(target: "WePLiVoting", path: "../Features/WePLiVoting"),
                .project(target: "WePLiMyPage", path: "../Features/WePLiMyPage"),
                .project(target: "WePLiSearch", path: "../Features/WePLiSearch"),
                
                // External Dependencies (TCA)
                .external(name: "ComposableArchitecture"),
                .external(name: "GoogleSignIn")
            ]
        ),
        Target(
            name: "WePLiTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.wepli.app.tests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "WePLi")
            ]
        ),
        Target(
            name: "WePLiUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "com.wepli.app.uitests",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .default,
            sources: ["UITests/**"],
            dependencies: [
                .target(name: "WePLi")
            ]
        )
    ]
)