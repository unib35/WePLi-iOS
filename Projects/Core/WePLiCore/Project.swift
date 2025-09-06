import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "WePLiCore",
    product: .framework,
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.10.2")),
        .remote(url: "https://github.com/Moya/Moya", requirement: .upToNextMajor(from: "15.0.3"))
    ],
    dependencies: [
        .package(product: "ComposableArchitecture"),
        .package(product: "Moya")
    ]
)
