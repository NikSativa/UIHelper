#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import XCTest

@MainActor
final class NavigationBarStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UINavigationBar = .init()
        var style: ViewStyle<NavigationBarStyleProperty> = .init([
            .titleColor(.red),
            .titleFont(UIFont.systemFont(ofSize: 11)),
            .backgroundColor(.green),
            .tintColor(.brown),
            .barTintColor(.yellow),
            .isTranslucent(true),
            .shadowImage(.testMake(.four)),
            .backgroundImage(.testMake(.three), state: .compact)
        ])

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        view.titleTextAttributes = nil
        style = .init([
            .titleFont(UIFont.systemFont(ofSize: 22)),
            .titleColor(.gray),
            .backgroundColor(.red),
            .tintColor(.yellow),
            .barTintColor(.brown),
            .isTranslucent(false),
            .shadowImage(.testMake(.three)),
            .backgroundImage(.testMake(.one), state: .compact)
        ])

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
#endif
