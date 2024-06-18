#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit

public final class FakeAppWindowProvider: AppWindowProviding, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case appWindow = "appWindow()"
        case appRootViewController = "appRootViewController()"
    }

    public init() {}

    public func appWindow() -> UIWindow {
        return spryify()
    }

    public func appRootViewController() -> UIViewController {
        return spryify()
    }
}
#endif
