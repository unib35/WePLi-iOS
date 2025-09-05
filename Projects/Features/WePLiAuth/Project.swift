import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "WePLiAuth",
    product: .staticFramework,
    dependencies: [
        .project(target: "WePLiCore", path: .relativeToRoot("Projects/Core/WePLiCore")),
        .project(target: "WePLiKit", path: .relativeToRoot("Projects/Core/WePLiKit")),
        .external(name: "ComposableArchitecture"),
        .external(name: "GoogleSignIn")
    ]
)