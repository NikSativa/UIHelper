#if canImport(UIKit) && os(iOS)
import Foundation
import UIHelper
import XCTest

@MainActor
@inline(__always)
public func XCTAssertStyle<T: StylePropertyTestable>(_ style: ViewStyle<T>,
                                                     beAppliedTo view: T.ViewType?,
                                                     file: StaticString = #filePath,
                                                     line: UInt = #line) {
    guard let view else {
        XCTFail("\(T.ViewType.self) is nil", file: file, line: line)
        return
    }

    let failed = style.notAppliedProperty(to: view)
    XCTAssertNil(failed, "\(String(describing: failed))", file: file, line: line)
}
#endif
