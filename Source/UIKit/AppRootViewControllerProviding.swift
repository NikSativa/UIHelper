#if canImport(UIKit) && os(iOS)
import UIKit

public protocol AppRootViewControllerProviding {
    func appRootViewController() -> UIViewController
}
#endif
