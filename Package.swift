// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "curryfire",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "curryfire",
            targets: ["curryfire", "CurryFireSwift"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/devinross/curry.git", from: "1.0.0"),
    ],
    targets: [
        // Objective-C sources. Public headers are exposed through the flat
        // symlink directory `curryfire/include`, which keeps the quoted imports
        // in the .m files working while giving SwiftPM a single headers root.
        .target(
            name: "curryfire",
            dependencies: [
                .product(name: "curry", package: "curry"),
            ],
            path: "curryfire",
            exclude: [
                "CurryFireSwift",
            ],
            publicHeadersPath: "include"
        ),
        // Swift-only extensions. SwiftPM targets can't mix Swift and
        // Objective-C, so these live in their own module.
        .target(
            name: "CurryFireSwift",
            dependencies: [
                "curryfire",
                .product(name: "curry", package: "curry"),
            ],
            path: "curryfire/CurryFireSwift",
            resources: [
                .process("CurryFireImages.xcassets")
            ],
            swiftSettings: [
                .swiftLanguageMode(.v5)
            ]
        ),
    ]
)
