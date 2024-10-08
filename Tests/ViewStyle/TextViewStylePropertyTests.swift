#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import XCTest

@MainActor
final class TextViewStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UITextView = .init()
        var style: ViewStyle<TextViewStyleProperty> = .init([
            .textColor(.red),
            .textFont(.systemFont(ofSize: 11)),
            .tintColor(.green),
            .borderWidth(11),
            .borderColor(.brown),
            .textContainerInset(.init(top: 10, left: 10, bottom: 10, right: 10)),
            .linkTextAttributes(.white)
        ])
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = .init([
            .textColor(.green),
            .textFont(.systemFont(ofSize: 22)),
            .tintColor(.yellow),
            .borderWidth(33),
            .borderColor(.black),
            .textContainerInset(.init(top: 30, left: 10, bottom: 10, right: 10)),
            .linkTextAttributes(.magenta)
        ])
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
#endif
