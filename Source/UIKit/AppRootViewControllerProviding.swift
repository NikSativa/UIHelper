#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
public protocol AppRootViewControllerProviding: Sendable {
    func appRootViewController() -> UIViewController
}

#endif
