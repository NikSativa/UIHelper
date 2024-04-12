// swift-tools-version:5.5
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "UIKitHelper",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "UIKitHelper", targets: ["UIKitHelper"]),
        .library(name: "UIKitHelperTestHelpers", targets: ["UIKitHelperTestHelpers"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "2.2.3"))
    ],
    targets: [
        .target(name: "UIKitHelper",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "UIKitHelperTestHelpers",
                dependencies: [
                    "UIKitHelper",
                    "SpryKit"
                ],
                path: "TestHelpers",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "UIKitHelperTests",
                    dependencies: [
                        "SpryKit",
                        "UIKitHelper",
                        "UIKitHelperTestHelpers"
                    ],
                    path: "Tests")
    ]
)
