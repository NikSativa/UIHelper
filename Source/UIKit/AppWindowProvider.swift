#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
public protocol AppWindowProviding: AppRootViewControllerProviding {
    func appWindow() -> UIWindow
}

@MainActor
public final class AppWindowProvider {
    private let window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - AppWindowProviding

@MainActor
extension AppWindowProvider: AppWindowProviding {
    public func appWindow() -> UIWindow {
        return window
    }

    public func appRootViewController() -> UIViewController {
        guard let rootViewController = window.rootViewController else {
            assertionFailure("Cannot present a full screen modal when you don't have a rootViewController")
            return UIViewController()
        }
        return rootViewController
    }
}

#if swift(>=6.0)
extension AppWindowProvider: @unchecked Sendable {}
#endif

#endif
