// swift-tools-version:5.5
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "UIHelper",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "UIHelper", targets: ["UIHelper"]),
        .library(name: "UIHelperTestHelpers", targets: ["UIHelperTestHelpers"])
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
        .target(name: "UIHelperTestHelpers",
                dependencies: [
                    "UIHelper",
                    "SpryKit"
                ],
                path: "TestHelpers",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "UIHelperTests",
                    dependencies: [
                        "SpryKit",
                        "UIHelper",
                        "UIHelperTestHelpers"
                    ],
                    path: "Tests")
    ]
)
