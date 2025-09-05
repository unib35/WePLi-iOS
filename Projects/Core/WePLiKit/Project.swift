import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "WePLiKit",
    product: .framework,
    dependencies: [
        .project(target: "WePLiResource", path: .relativeToRoot("Projects/Core/WePLiResource")),
        .external(name: "Kingfisher"),
        .external(name: "Lottie")
    ]
)