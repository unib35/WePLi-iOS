import ProjectDescription

public enum SharedSettings {
  public static let base: Settings = .settings(
    base: [
      "IPHONEOS_DEPLOYMENT_TARGET": "16.0",
      "SWIFT_VERSION": "5.10",
    ],
    configurations: [
      .debug(name: "Debug"),
      .release(name: "Release"),
    ]
  )
}
