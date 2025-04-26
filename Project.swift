import ProjectDescription

let project = Project(
    name: "WePLi-iOS",
    targets: [
        .target(
            name: "WePLi-iOS",
            destinations: .iOS,
            product: .app,
            bundleId: "com.lee.wepli",
            infoPlist: .default,
            sources: ["WePLi-iOS/Sources/**"],
            resources: ["WePLi-iOS/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "WePLi-iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.lee.wepli.tests",
            infoPlist: .default,
            sources: ["WePLi-iOS/Tests/**"],
            resources: [],
            dependencies: [.target(name: "WePLi-iOS")]
        ),
    ]
)
