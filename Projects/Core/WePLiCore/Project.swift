import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
  name: "WePLiCore",
  product: .framework,
  dependencies: [
    .external(name: "ComposableArchitecture"),
    .external(name: "Supabase")
  ],
  includeDemo: false
)