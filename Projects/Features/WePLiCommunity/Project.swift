import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
  name: "WePLiCommunity",
  product: .framework,
  dependencies: [
    .external(name: "ComposableArchitecture"),
    .external(name: "Kingfisher"),
    .project(target: "WePLiCore", path: "../../Core/WePLiCore"),
    .project(target: "WePLiResource", path: "../../Core/WePLiResource")
  ],
  includeDemo: true
)