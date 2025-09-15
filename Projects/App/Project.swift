import ProjectDescription
import ProjectDescriptionHelpers

// --- Build Scripts ---
let swiftGenScript: TargetScript = .pre(
  script: #"""
  if command -v swiftgen >/dev/null 2>&1; then
    echo "Running SwiftGen…"
    swiftgen config run --config "${SRCROOT}/Configs/swiftgen.yml"
  else
    echo "warning: SwiftGen not installed"
  fi
  """#,
  name: "SwiftGen",
  basedOnDependencyAnalysis: false
)

let swiftLintScript: TargetScript = .pre(
  script: #"""
  if command -v swiftlint >/dev/null 2>&1; then
    echo "Running SwiftLint (non-strict)…"
    swiftlint --quiet --config "${SRCROOT}/.swiftlint.yml" || true
  else
    echo "warning: SwiftLint not installed"
  fi
  """#,
  name: "SwiftLint (non-strict)",
  basedOnDependencyAnalysis: false
)

// --- Project ---
let project = Project(
  name: "WePLi",
  settings: .settings(
    base: SharedSettings.base.base,
    configurations: [
      .debug(name: "Debug", xcconfig: .relativeToRoot("Configs/Debug.xcconfig")),
      .release(name: "Release", xcconfig: .relativeToRoot("Configs/Release.xcconfig")),
    ]
  ),
  targets: [
    .target(
      name: "WePLi",
      destinations: .iOS,
      product: .app,
      bundleId: "com.example.wepli",
      deploymentTargets: .iOS("16.0"),
      infoPlist: .extendingDefault(with: [
        "UILaunchScreen": [:],
        "API_BASE_URL": "$(API_BASE_URL)",
        "LOG_LEVEL": "$(LOG_LEVEL)",
        "CFBundleURLTypes": [
          [
            "CFBundleURLName": "com.example.wepli",
            "CFBundleURLSchemes": ["com.googleusercontent.apps.YOUR_REVERSED_CLIENT_ID"],
          ],
        ],
      ]),
      sources: ["Sources/**", "Generated/**"],
      resources: ["Resources/**"],
      entitlements: .file(path: .relativeToManifest("App.entitlements")),
      scripts: [
        swiftGenScript,
        swiftLintScript,
      ],
      dependencies: [
        .external(name: "Moya"),
        .external(name: "Kingfisher"),
        .external(name: "ComposableArchitecture"),
        .external(name: "GoogleSignIn"),
        .external(name: "GoogleSignInSwift"),
        .external(name: "Supabase"),
        .external(name: "KeychainAccess"),
      ]
    ),
    .target(
      name: "WePLiTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.example.wepli.tests",
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: "WePLi")]
    ),
  ]
)
