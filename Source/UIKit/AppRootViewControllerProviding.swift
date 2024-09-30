#if canImport(UIKit) && os(iOS)
import UIKit

#if swift(>=6.0)
@MainActor
public protocol AppRootViewControllerProviding: Sendable {
    func appRootViewController() -> UIViewController
}
#else
@MainActor
public protocol AppRootViewControllerProviding {
    func appRootViewController() -> UIViewController
}
#endif

#endif
