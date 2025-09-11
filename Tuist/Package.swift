// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [
            "ComposableArchitecture": .framework,
            "Kingfisher": .framework,
            "Moya": .framework,
            "GoogleSignIn": .framework,
            "Supabase": .framework,
            "Lottie": .framework
        ]
    )
#endif

let package = Package(
    name: "WePLi-iOS",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.2"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.11.0"),
        .package(url: "https://github.com/Moya/Moya", from: "15.0.3"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS", from: "7.1.0"),
        .package(url: "https://github.com/supabase-community/supabase-swift", from: "2.5.0"),
        .package(url: "https://github.com/airbnb/lottie-ios", from: "4.4.1")
    ]
)