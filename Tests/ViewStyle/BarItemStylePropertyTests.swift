#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import UITestHelpers
import XCTest

final class BarItemStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UIBarButtonItem = .init()
        let style: ViewStyle<BarItemStyleProperty> = [
            .textColor(.red, .normal),
            .textColor(.green, .highlighted),
            .textColor(.blue, .disabled),
            .textFont(UIFont.systemFont(ofSize: 10), .normal),
            .textFont(UIFont.systemFont(ofSize: 15), .highlighted),
            .textFont(UIFont.systemFont(ofSize: 20), .disabled)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
#endif
