import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.10.2")),
    .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.11.0")),
    .remote(url: "https://github.com/Moya/Moya", requirement: .upToNextMajor(from: "15.0.3")),
    .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .upToNextMajor(from: "7.1.0")),
    .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from: "4.4.1"))
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)