#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import XCTest

@MainActor
final class ViewStyleTests: XCTestCase {
    private typealias Style = ViewStyle<LabelStyleProperty>

    @MainActor
    private enum Constant {
        static let softBlackStyle: Style = .init([.textColor(.black)])

        static let brandonRegular15SoftBlack: LabelStyleProperty = .textFont(.systemFont(ofSize: 10))
        static let brandonRegular15SoftBlackStyle: Style = .init([brandonRegular15SoftBlack])
    }

    func test_spec() {
        let label: UILabel = .init()
        var style: ViewStyle<LabelStyleProperty> = ViewStyle(properties: .backgroundColor(.red))

        // apply first random style
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // style constructor
        style = Constant.softBlackStyle + Constant.brandonRegular15SoftBlack
        let expected: Style = .init([
            .textColor(.black),
            .textFont(.systemFont(ofSize: 10))
        ])
        XCTAssertEqual(expected, style)

        // apply style
        Constant.softBlackStyle.apply(to: label)
        XCTAssertStyle(Constant.softBlackStyle, beAppliedTo: label)

        // style + style
        style = Constant.softBlackStyle + Constant.brandonRegular15SoftBlackStyle
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // style + property
        style = Constant.softBlackStyle + Constant.brandonRegular15SoftBlack
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // property + style
        style = Constant.brandonRegular15SoftBlack + Constant.softBlackStyle
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // += style
        style = Constant.softBlackStyle
        style += Constant.brandonRegular15SoftBlackStyle
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)

        // += property
        style = Constant.softBlackStyle
        style += Constant.brandonRegular15SoftBlack
        style.apply(to: label)
        XCTAssertStyle(style, beAppliedTo: label)
    }
}
#endif
