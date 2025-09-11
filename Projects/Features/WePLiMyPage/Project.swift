import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
  name: "WePLiMyPage",
  product: .framework,
  dependencies: [
    .external(name: "ComposableArchitecture"),
    .project(target: "WePLiCore", path: "../../Core/WePLiCore"),
    .project(target: "WePLiResource", path: "../../Core/WePLiResource")
  ],
  includeDemo: true,
  demoSources: ["Demo/Sources/**"],
  demoResources: []
)