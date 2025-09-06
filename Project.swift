import ProjectDescription

let projectName = "WePLi"

let configurations: [Configuration] = [
  .debug(name: "Debug-Dev", xcconfig: "Configs/Dev.xcconfig"),
  .debug(name: "Debug-Staging", xcconfig: "Configs/Staging.xcconfig"),
  .release(name: "Release-Prod", xcconfig: "Configs/Prod.xcconfig")
]

let settings = Settings.settings(configurations: configurations)

// 네 저장소에 폴더명이 'scripts' 라면 경로도 소문자 scripts로 맞춰줘
let swiftLint = TargetScript.pre(
  path: "scripts/swiftlint.sh",
  arguments: [],
  name: "SwiftLint",
  basedOnDependencyAnalysis: false
)

let project = Project(
  name: projectName,
  settings: settings,
  targets: [
    .target(
      name: "App",
      destinations: .iOS,
      product: .app,
      bundleId: "com.lee.wepli",
      deploymentTargets: .iOS("16.0"),
      infoPlist: .extendingDefault(with: [
        "UILaunchScreen": [:],
        "CFBundleDisplayName": .string("WePLi")
      ]),
      sources: ["Targets/App/Sources/**"],
      resources: ["Targets/App/Resources/**"],
      scripts: [swiftLint],
      dependencies: []
    ),
    .target(
      name: "AppTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.lee.wepli.tests",
      deploymentTargets: .iOS("16.0"),
      infoPlist: .default,
      sources: ["Targets/App/Tests/**"],
      dependencies: [.target(name: "App")]
    )
  ]
)