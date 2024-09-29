#if canImport(UIKit) && os(iOS)
import Foundation
import SpryKit
import UIHelper
import UIKit

@MainActor
public extension KeyboardHandlerConfiguration {
    enum Constant {
        @MainActor
        public static let sharedView = UIView()
    }

    static func testMake(view: UIView = Constant.sharedView,
                         touchView: UIView? = nil,
                         delegate: KeyboardHandlerDelegate? = nil,
                         keyboardPadding: CGFloat = 0,
                         animated: Bool = true,
                         layoutIfNeeded: Bool = true) -> KeyboardHandlerConfiguration {
        return KeyboardHandlerConfiguration(view: view,
                                            touchView: touchView,
                                            delegate: delegate,
                                            keyboardPadding: keyboardPadding,
                                            animated: animated,
                                            layoutIfNeeded: layoutIfNeeded)
    }
}
#endif
