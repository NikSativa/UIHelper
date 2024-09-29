#if canImport(UIKit) && os(iOS)
import Foundation
import SpryKit
import UIHelper
import UIKit

public final class FakeAppRootViewControllerProvider: AppRootViewControllerProviding, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case appRootViewController = "appRootViewController()"
    }

    public func appRootViewController() -> UIViewController {
        return spryify()
    }
}
#endif
