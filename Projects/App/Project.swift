import ProjectDescription

let project = Project(
    name: "WePLi",
    organizationName: "com.wepli",
    packages: [],
    settings: Settings.settings(
        base: [:],
        configurations: [
            .debug(name: "Debug-Dev", xcconfig: .relativeToRoot("Configs/Dev.xcconfig")),
            .debug(name: "Debug-Staging", xcconfig: .relativeToRoot("Configs/Staging.xcconfig")),
            .release(name: "Release-Prod", xcconfig: .relativeToRoot("Configs/Prod.xcconfig"))
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
                "CFBundleURLTypes": [
                    [
                        "CFBundleURLSchemes": [
                            "$(GOOGLE_REVERSED_CLIENT_ID)"
                        ]
                    ]
                ],
                "SUPABASE_URL": "$(SUPABASE_URL)",
                "SUPABASE_ANON_KEY": "$(SUPABASE_ANON_KEY)",
                "GOOGLE_CLIENT_ID": "$(GOOGLE_CLIENT_ID)"
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .file(path: "App.entitlements"),
            scripts: [
                .pre(
                    path: .relativeToRoot("Scripts/swiftlint.sh"),
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

                .external(name: "ComposableArchitecture"),
                .external(name: "GoogleSignIn"),
                .external(name: "Supabase")
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