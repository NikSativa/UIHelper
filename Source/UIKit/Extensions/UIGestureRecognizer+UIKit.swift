#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
public extension UIGestureRecognizer {
    var isTouchUpInside: Bool {
        guard state == .ended else {
            return false
        }

        guard let view else {
            return false
        }

        let location = location(in: view)
        let bounds = view.bounds
        return bounds.contains(location)
    }
}
#endif
