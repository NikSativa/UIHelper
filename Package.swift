// swift-tools-version:5.9
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "UIHelper",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .visionOS(.v1),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "UIHelper", targets: ["UIHelper"]),
        .library(name: "UITestHelpers", targets: ["UITestHelpers"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "2.2.3"))
    ],
    targets: [
        .target(name: "UIHelper",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "UITestHelpers",
                dependencies: [
                    "UIHelper",
                    "SpryKit"
                ],
                path: "TestHelpers",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "UITests",
                    dependencies: [
                        "SpryKit",
                        "UIHelper",
                        "UITestHelpers"
                    ],
                    path: "Tests")
    ]
)
