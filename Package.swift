// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TinyNetworking",
    products: [
        .library(
            name: "TinyNetworking",
            targets: ["TinyNetworking"]
        ),
        .library(
            name: "RxTinyNetworking",
            targets: ["RxTinyNetworking"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(
            name: "TinyNetworking",
            dependencies: [],
            path: "Sources/TinyNetworking"
        ),
        .target(
            name: "RxTinyNetworking",
            dependencies: ["TinyNetworking", "RxSwift"],
            path: "Sources/RxTinyNetworking"
        )
    ]
)
