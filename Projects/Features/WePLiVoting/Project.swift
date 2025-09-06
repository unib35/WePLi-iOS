import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "WePLiVoting",
    product: .staticFramework,
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.10.2"))
    ],
    dependencies: [
        .project(target: "WePLiCore", path: .relativeToRoot("Projects/Core/WePLiCore")),
        .project(target: "WePLiKit", path: .relativeToRoot("Projects/Core/WePLiKit")),
        .package(product: "ComposableArchitecture")
    ]
)
