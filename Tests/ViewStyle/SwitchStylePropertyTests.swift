#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import XCTest

@MainActor
final class SwitchStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UISwitch = .init()
        var style: ViewStyle<SwitchStyleProperty> = .init([
            .tintColor(.red),
            .thumbTintColor(.green),
            .onTintColor(.blue)
        ])
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = .init([
            .tintColor(.white),
            .thumbTintColor(.gray),
            .onTintColor(.black)
        ])
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
#endif
