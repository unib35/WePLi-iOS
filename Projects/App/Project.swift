import ProjectDescription

let project = Project(
    name: "WePLi",
    organizationName: "com.wepli",
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.10.2")),
        .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .upToNextMajor(from: "7.1.0"))
    ],
    settings: Settings.settings(
        base: [:],
        configurations: [
            .debug(name: "Debug-Dev", xcconfig: "../../Configs/Dev.xcconfig"),
            .debug(name: "Debug-Staging", xcconfig: "../../Configs/Staging.xcconfig"),
            .release(name: "Release-Prod", xcconfig: "../../Configs/Prod.xcconfig")
        ]
    ),
    targets: [
        .target(
            name: "WePLi",
            destinations: .iOS,
            product: .app,
            bundleId: "com.wepli.app",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen",
                "CFBundleDisplayName": "WePLi",
                "UIUserInterfaceStyle": "Light",
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
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

                // External Dependencies
                .package(product: "ComposableArchitecture"),
                .package(product: "GoogleSignIn")
            ]
        ),
        .target(
            name: "WePLiTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.wepli.app.tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "WePLi")
            ]
        ),
        .target(
            name: "WePLiUITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "com.wepli.app.uitests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["UITests/**"],
            dependencies: [
                .target(name: "WePLi")
            ]
        )
    ]
)
