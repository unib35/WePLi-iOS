import ProjectDescription

/// Tuist 4.x 버전에 호환되는 최종 프로젝트 템플릿 헬퍼입니다.
public extension Project {
    static func makeModule(
        name: String,
        destinations: Destinations = .iOS,
        product: Product,
        organizationName: String = "com.wepli",
        packages: [Package] = [],
        deploymentTargets: DeploymentTargets? = .iOS("16.0"),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {

        // MARK: - Project Settings
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: "Debug-Dev", xcconfig: .relativeToRoot("Configs/Dev.xcconfig")),
                .debug(name: "Debug-Staging", xcconfig: .relativeToRoot("Configs/Staging.xcconfig")),
                .release(name: "Release-Prod", xcconfig: .relativeToRoot("Configs/Prod.xcconfig"))
            ],
            defaultSettings: .recommended
        )

        // MARK: - Main Target
        let mainTarget: Target = .target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: "\(organizationName).\(name)",
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            scripts: [
                .pre(
                    path: .relativeToRoot("Scripts/swiftlint.sh"),
                    name: "SwiftLint",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: dependencies,
            settings: product == .app ? nil : .settings(base: ["DEFINES_MODULE": "YES"])
        )

        // MARK: - Test Target
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

        // MARK: - Demo App Target (Framework 전용)
        let demoTarget: Target = .target(
            name: "\(name)Demo",
            destinations: destinations,
            // 👇 product 와 productName 의 순서를 바로잡았습니다.
            product: .app,
            productName: "\(name)Demo",
            bundleId: "\(organizationName).\(name)Demo",
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen",
                "CFBundleDisplayName": "\(name) Demo",
                "UIUserInterfaceStyle": "Light",
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"]
            ]),
            sources: ["Demo/Sources/**"],
            resources: ["Demo/Resources/**"],
            dependencies: [.target(name: name)]
        )
        
        // MARK: - Targets & Schemes
        let targets: [Target] = if product == .app {
            [mainTarget, testTarget]
        } else {
            [mainTarget, testTarget, demoTarget]
        }
        
        let schemes: [Scheme] = if product == .app {
            [.makeScheme(name: name)]
        } else {
            [.makeScheme(name: name), .makeDemoScheme(name: name)]
        }

        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
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
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
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
            buildAction: .buildAction(targets: ["\(name)Demo"]),
            testAction: nil,
            runAction: .runAction(
                configuration: target,
                executable: "\(name)Demo"
            ),
            archiveAction: .archiveAction(configuration: .configuration("Release-Prod")),
            profileAction: .profileAction(configuration: .configuration("Release-Prod")),
            analyzeAction: .analyzeAction(configuration: .configuration("Debug-Dev"))
        )
    }
}

