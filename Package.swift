// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DisneylandTripAssistant",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "TripCore", targets: ["TripCore"]),
        .library(name: "TripApp", targets: ["TripApp"]),
        .executable(name: "TripAppPreview", targets: ["TripAppPreview"])
    ],
    targets: [
        .target(name: "TripCore"),
        .target(name: "TripApp", dependencies: ["TripCore"]),
        .executableTarget(name: "TripAppPreview", dependencies: ["TripApp"]),
        .testTarget(name: "TripCoreTests", dependencies: ["TripCore"])
    ]
)
