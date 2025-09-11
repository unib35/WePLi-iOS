import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
  name: "WePLiKit",
  product: .framework,
  dependencies: [
    .external(name: "ComposableArchitecture")
  ],
  includeDemo: false
)