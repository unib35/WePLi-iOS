import ProjectDescription

let project = Project(
    name: "WePLi-iOS",
    targets: [
        .target(
            name: "WePLi-iOS",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.WePLi-iOS",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["WePLi-iOS/Sources/**"],
            resources: ["WePLi-iOS/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "WePLi-iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.WePLi-iOSTests",
            infoPlist: .default,
            sources: ["WePLi-iOS/Tests/**"],
            resources: [],
            dependencies: [.target(name: "WePLi-iOS")]
        ),
    ]
)
