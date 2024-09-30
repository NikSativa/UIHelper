#if canImport(UIKit) && os(iOS)
import UIKit

#if swift(>=6.0)
@MainActor
public protocol KeyboardHandling: Sendable {
    typealias ExcludedViews = @Sendable () -> [UIView]
    func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews?)
}
#else
@MainActor
public protocol KeyboardHandling {
    typealias ExcludedViews = () -> [UIView]
    func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews?)
}
#endif

public extension KeyboardHandling {
    func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews? = nil) {
        enable(for: configuration, excluded: excluded)
    }

    func enable(for view: UIScrollView, touchView: UIView, excluded: ExcludedViews? = nil) {
        enable(for: .init(view: view, touchView: touchView), excluded: excluded)
    }
}

#endif
