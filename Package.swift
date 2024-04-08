// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift_gluon-server",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        //.package(url: "https://github.com/Kitura/BlueSocket.git", from: "2.0.2"),
        //.package(url: "https://github.com/apple/swift-nio.git", from: "2.57.0"),
        
        .package(url: "https://github.com/vapor/vapor.git", from: "4.92.5"),
        .package(url: "https://github.com/vapor/console-kit.git", from: "4.14.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.8.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.5.0"),
        .package(url: "https://github.com/vapor/postgres-nio.git", from: "1.21.1"),
        .package(url: "https://github.com/vapor/postgres-kit.git", from: "2.13.1"),
        
        .package(url: "https://github.com/Kitura/BlueSocket.git", from: "2.0.4"),
        .package(url: "https://github.com/apple/swift-asn1.git", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                //.product(name: "BlueSocket", package: "BlueSocket"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                
                .product(name: "Socket", package: "BlueSocket"),
                .product(name: "SwiftASN1", package: "swift-asn1")
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "swift_gluon-serverTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor")
        ]),
    ]
)
