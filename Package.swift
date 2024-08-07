// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "swift_gluon-server",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        //.package(url: "https://github.com/apple/swift-nio.git", from: "2.57.0"),
        .package(url: "https://github.com/apple/swift-syntax.git", from: "510.0.2"),
        
        .package(url: "https://github.com/vapor/vapor.git", from: "4.101.0"),
        .package(url: "https://github.com/vapor/console-kit.git", from: "4.14.2"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.10.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.9.2"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.7.2"),
        .package(url: "https://github.com/vapor/postgres-nio.git", from: "1.21.2"),
        .package(url: "https://github.com/vapor/postgres-kit.git", from: "2.13.4"),
        
        .package(url: "https://github.com/Kitura/BlueSocket.git", from: "2.0.4"),
        .package(url: "https://github.com/apple/swift-asn1.git", from: "1.1.0"),

        .package(url: "https://github.com/RandomHashTags/swift-language-codes.git", from: "1.0.0"),
        .package(url: "https://github.com/RandomHashTags/swift-string-catalogs.git", from: "1.0.0")
    ],
    targets: [
        .macro(
            name: "GluonMacros",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .macro(
            name: "MinecraftMacros",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        .target(
            name: "App",
            dependencies: [
                "GluonMacros",
                "MinecraftMacros",
                //.product(name: "BlueSocket", package: "BlueSocket"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                
                .product(name: "Socket", package: "BlueSocket"),
                .product(name: "SwiftASN1", package: "swift-asn1"),
                .product(name: "SwiftLanguageCodes", package: "swift-language-codes"),
                .product(name: "SwiftStringCatalogs", package: "swift-string-catalogs")
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
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
