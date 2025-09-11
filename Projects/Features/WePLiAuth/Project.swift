import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
  name: "WePLiAuth",
  product: .framework,
  dependencies: [
    .external(name: "ComposableArchitecture"),
    .project(target: "WePLiResource", path: "../../Core/WePLiResource"),
    .project(target: "WePLiCore", path: "../../Core/WePLiCore")
  ],
  // 데모 필요하면 true로, 리소스 없으면 경고 방지 위해 빈 배열
  includeDemo: true,
  demoSources: ["Demo/Sources/**"],
  demoResources: []
)