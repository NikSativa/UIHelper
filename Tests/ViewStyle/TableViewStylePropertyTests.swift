#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit
import XCTest

@MainActor
final class TableViewStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UITableView = .init()
        var style: ViewStyle<TableViewStyleProperty> = .init([
            .estimatedRowHeight(11),
            .rowHeight(22),
            .backgroundColor(.red),
            .sectionHeaderHeight(33),
            .sectionFooterHeight(44),
            .separatorColor(.green),
            .separatorInset(2),
            .separatorStyle(.singleLine)
        ])
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = .init([
            .estimatedRowHeight(22),
            .rowHeight(33),
            .backgroundColor(.green),
            .sectionHeaderHeight(44),
            .sectionFooterHeight(55),
            .separatorColor(.red),
            .separatorInset(1),
            .separatorStyle(.none)
        ])
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
#endif
