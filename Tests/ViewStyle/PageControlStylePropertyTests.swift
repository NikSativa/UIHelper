#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import XCTest

@MainActor
final class PageControlStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UIPageControl = .init()
        var style: ViewStyle<PageControlStyleProperty> = [
            .pageIndicatorTintColor(.red),
            .currentPageIndicatorTintColor(.green)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .pageIndicatorTintColor(.brown),
            .currentPageIndicatorTintColor(.yellow)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
#endif
