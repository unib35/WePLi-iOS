import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "WePLiResource",
    product: .framework,
    dependencies: [],
    resources: ["Resources/**"]
)
