import ProjectDescription

/// Tuist 4.x 버전에 호환되며, 유연성과 편의성이 강화된 최종 프로젝트 템플릿 헬퍼입니다.
public extension Project {
  static func makeModule(
    name: String,
    destinations: Destinations = .iOS,
    product: Product,
    organizationName: String = "com.wepli",
    deploymentTargets: DeploymentTargets? = .iOS("16.0"),
    dependencies: [TargetDependency] = [],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    infoPlist: InfoPlist = .default,
    additionalInfoPlist: [String: Plist.Value] = [:],
    entitlements: Entitlements? = nil,
    includeDemo: Bool = false,
    demoSources: SourceFilesList = ["Demo/Sources/**"],
    demoResources: ResourceFileElements? = nil
  ) -> Project {

    let settings: Settings = .settings(
      base: [:],
      configurations: [
        .debug(name: "Debug-Dev", xcconfig: .relativeToRoot("Configs/Dev.xcconfig")),
        .debug(name: "Debug-Staging", xcconfig: .relativeToRoot("Configs/Staging.xcconfig")),
        .release(name: "Release-Prod", xcconfig: .relativeToRoot("Configs/Prod.xcconfig"))
      ],
      defaultSettings: .recommended
    )

    let mergedInfoPlist: InfoPlist = {
      switch infoPlist {
      case let .extendingDefault(values):
        let merged = values.merging(additionalInfoPlist) { _, new in new }
        return .extendingDefault(with: merged)
      case let .dictionary(values):
        let merged = values.merging(additionalInfoPlist) { _, new in new }
        return .dictionary(merged)
      default:
        return additionalInfoPlist.isEmpty
          ? infoPlist
          : .extendingDefault(with: additionalInfoPlist)
      }
    }()

    let mainTarget: Target = .target(
      name: name,
      destinations: destinations,
      product: product,
      bundleId: "\(organizationName).\(name)",
      deploymentTargets: deploymentTargets,
      infoPlist: mergedInfoPlist,
      sources: sources,
      resources: resources,
      entitlements: entitlements,
      scripts: [
        .pre(
          path: .relativeToRoot("Scripts/swiftlint.sh"),
          name: "SwiftLint",
          inputPaths: ["$(SRCROOT)/Sources/**"],
          outputPaths: ["$(DERIVED_FILES_DIR)/swiftlint.out"],
          basedOnDependencyAnalysis: true
        )
      ],
      dependencies: dependencies,
      settings: product == .app ? nil : .settings(base: ["DEFINES_MODULE": "YES"])
    )

    let testTarget: Target = .target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "\(organizationName).\(name)Tests",
      deploymentTargets: deploymentTargets,
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: name)]
    )

    var targets: [Target] = [mainTarget, testTarget]
    var schemes: [Scheme] = [.makeScheme(name: name)]

    if product != .app, includeDemo {
      targets.append(
        .target(
          name: "\(name)Demo",
          destinations: destinations,
          product: .app,
          productName: "\(name)Demo",
          bundleId: "\(organizationName).\(name)Demo",
          deploymentTargets: deploymentTargets,
          infoPlist: .extendingDefault(with: [
            "UILaunchStoryboardName": "LaunchScreen",
            "CFBundleDisplayName": "\(name) Demo"
          ]),
          sources: demoSources,
          resources: demoResources,
          dependencies: [.target(name: name)]
        )
      )
      schemes.append(.makeDemoScheme(name: name))
    }

    return Project(
      name: name,
      organizationName: organizationName,
      settings: settings,
      targets: targets,
      schemes: schemes
    )
  }
}

// MARK: - Scheme Helper
extension Scheme {
    /// 기본 모듈과 유닛 테스트를 위한 Scheme을 생성합니다.
    static func makeScheme(name: String, target: ConfigurationName = .configuration("Debug-Dev")) -> Scheme {
        return .scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: [.target(name)]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: [.target(name)])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: .configuration("Release-Prod")),
            profileAction: .profileAction(configuration: .configuration("Release-Prod")),
            analyzeAction: .analyzeAction(configuration: .configuration("Debug-Dev"))
        )
    }

    /// 데모 앱 실행을 위한 Scheme을 생성합니다.
    static func makeDemoScheme(name: String, target: ConfigurationName = .configuration("Debug-Dev")) -> Scheme {
        return .scheme(
            name: "\(name)Demo",
            shared: true,
            buildAction: .buildAction(targets: [.target("\(name)Demo")]),
            testAction: nil,
            runAction: .runAction(configuration: target, executable: .target("\(name)Demo")),
            archiveAction: .archiveAction(configuration: .configuration("Release-Prod")),
            profileAction: .profileAction(configuration: .configuration("Release-Prod")),
            analyzeAction: .analyzeAction(configuration: .configuration("Debug-Dev"))
        )
    }
}

