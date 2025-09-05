import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "WePLiKit",
    product: .framework,
    packages: [
        .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.11.0")),
        .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from: "4.4.1"))
    ],
    dependencies: [
        .project(target: "WePLiResource", path: .relativeToRoot("Projects/Core/WePLiResource")),
        .package(product: "Kingfisher"),
        .package(product: "Lottie")
    ]
)
