#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import UITestHelpers
import XCTest

final class ImageViewStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UIImageView = .init()
        var style: ViewStyle<ImageViewStyleProperty> = [
            .tintColor(.red),
            .borderColor(.green),
            .borderWidth(1),
            .contentMode(.bottom),
            .cornerRadius(2),
            .clipsToBounds(true)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .tintColor(.green),
            .borderColor(.brown),
            .borderWidth(2),
            .contentMode(.center),
            .cornerRadius(3),
            .clipsToBounds(false)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
#endif
