#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit

extension StackViewStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UIStackView) -> Bool {
        switch self {
        case .margins(let value):
            return view.layoutMargins == value && view.isLayoutMarginsRelativeArrangement
        case .spacing(let value):
            return view.spacing == value
        case .axis(let value):
            return view.axis == value
        }
    }
}
#endif
