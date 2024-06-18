#if canImport(UIKit) && os(iOS)
import SpryKit
import UIHelper
import UIKit

public final class FakeModalPresenter: ModalPresenting, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case present = "present(_:source:animated:completion:)"
        case dismissAnimated = "dismiss(animated:)"
        case topPresenter
    }

    public var topPresenter: UIViewController {
        return spryify()
    }

    private(set) var completionCallback: Callback?
    func present(_ viewController: UIViewController, source _: Source?, animated: Bool, completion: @escaping Callback) {
        completionCallback = completion
        return spryify(arguments: viewController, animated)
    }

    public func dismiss(animated: Bool) {
        return spryify(arguments: animated)
    }
}
#endif
