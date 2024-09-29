#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import XCTest

@MainActor
final class LabelStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UILabel = .init()
        var style: ViewStyle<LabelStyleProperty> = [
            .textColor(.red),
            .backgroundColor(.green),
            .textFont(.systemFont(ofSize: 11)),
            .textAlignment(.center),
            .numberOfLines(1)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .textColor(.blue),
            .backgroundColor(.yellow),
            .textFont(.systemFont(ofSize: 22)),
            .textAlignment(.left),
            .numberOfLines(11)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
#endif
