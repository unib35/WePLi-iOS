import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "WePLiMyPage",
    product: .staticFramework,
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.10.2")),
        .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.11.0"))
    ],
    dependencies: [
        .project(target: "WePLiCore", path: .relativeToRoot("Projects/Core/WePLiCore")),
        .project(target: "WePLiKit", path: .relativeToRoot("Projects/Core/WePLiKit")),
        .package(product: "ComposableArchitecture"),
        .package(product: "Kingfisher")
    ]
)
