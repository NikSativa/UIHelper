// swift-tools-version:6.0
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "UIHelper",
    platforms: [
        .iOS(.v15),
        .macOS(.v14),
        .macCatalyst(.v15),
        .visionOS(.v1),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "UIHelper", targets: ["UIHelper"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", from: "3.2.1")
    ],
    targets: [
        .target(name: "UIHelper",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .process("PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "UITests",
                    dependencies: [
                        "SpryKit",
                        "UIHelper"
                    ],
                    path: "Tests")
    ]
)
