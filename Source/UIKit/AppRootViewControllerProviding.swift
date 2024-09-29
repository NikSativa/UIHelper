#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
public protocol AppRootViewControllerProviding {
    func appRootViewController() -> UIViewController
}
#endif
