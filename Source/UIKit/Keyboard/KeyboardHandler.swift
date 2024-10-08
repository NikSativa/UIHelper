#if canImport(UIKit) && os(iOS)
import UIKit

#if swift(>=6.0)
@MainActor
public protocol KeyboardHandlerDelegate: AnyObject, Sendable {
    func didChange(bottomContentInset inset: CGFloat)
}
#else
@MainActor
public protocol KeyboardHandlerDelegate: AnyObject {
    func didChange(bottomContentInset inset: CGFloat)
}
#endif

@MainActor
public final class KeyboardHandler {
    private let transparentTouchView: TransparentTouchView
    private let notificationCenter: NotificationCenter
    private var configuration: KeyboardHandlerConfiguration?
    private var observers: [Any] = []
    private var animated: Bool {
        return configuration?.animated == true
    }

    @MainActor
    public init(notificationCenter: NotificationCenter = .default,
                transparentTouchView: TransparentTouchView = .init()) {
        self.notificationCenter = notificationCenter
        self.transparentTouchView = transparentTouchView

        observers.append(
            notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { [weak self] notification in
                let notification = UnsafeSendable(notification)
                #if swift(>=6.0)
                MainActor.assumeIsolated {
                    self?.keyboardWillShow(notification.value)
                }
                #else
                self?.keyboardWillShow(notification.value)
                #endif
            }
        )

        observers.append(
            notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] notification in
                let notification = UnsafeSendable(notification)
                #if swift(>=6.0)
                MainActor.assumeIsolated {
                    self?.keyboardWillHide(notification.value)
                }
                #else
                self?.keyboardWillHide(notification.value)
                #endif
            }
        )
    }

    deinit {
        Task.detached { @MainActor [transparentTouchView] in
            transparentTouchView.removeFromSuperview()
        }
    }
}

// MARK: - KeyboardHandling

extension KeyboardHandler: KeyboardHandling {
    public func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews?) {
        assert(self.configuration == nil, "dual initialization")
        self.configuration = configuration

        transparentTouchView.callback = { [weak self] in
            self?.configuration?.view.endEditing(true)
        }

        transparentTouchView.excluded = {
            return excluded?() ?? []
        }
    }

    private func animate(notification: Notification, _ newBottomInsetPlusKeyboardPadding: CGFloat) {
        if animated,
           let view = configuration?.view,
           let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            view.setNeedsLayout()
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIView.AnimationOptions(rawValue: curve),
                           animations: ({ [weak self] in
                               self?.configuration?.delegate?.didChange(bottomContentInset: newBottomInsetPlusKeyboardPadding)

                               if self?.configuration?.layoutIfNeeded == true {
                                   self?.configuration?.view.layoutIfNeeded()
                               }
                           }),
                           completion: nil)
        } else {
            configuration?.delegate?.didChange(bottomContentInset: newBottomInsetPlusKeyboardPadding)
        }
    }

    private func keyboardWillShow(_ notification: Notification) {
        guard let configuration else {
            return
        }

        if let touchView = configuration.touchView {
            touchView.addAndFill(transparentTouchView)
            transparentTouchView.widthAnchor.constraint(equalTo: touchView.widthAnchor).isActive = true
            transparentTouchView.heightAnchor.constraint(equalTo: touchView.heightAnchor).isActive = true
            touchView.bringSubviewToFront(transparentTouchView)
        }

        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let view = configuration.view
        let keyboardSize = keyboardValue.cgRectValue.size
        let viewRectFlattened = view.convert(view.bounds, to: nil)

        let bottomOfViewYPos = viewRectFlattened.origin.y + viewRectFlattened.size.height
        let bottomOfScreenYPos = UIScreen.main.bounds.height
        let distanceBetweenBottomOfScreenAndView = bottomOfScreenYPos - bottomOfViewYPos
        let newBottomInset = keyboardSize.height - distanceBetweenBottomOfScreenAndView
        let newBottomInsetPlusKeyboardPadding = newBottomInset + configuration.keyboardPadding

        if let scrollView = view as? UIScrollView {
            scrollView.contentInset.bottom = newBottomInsetPlusKeyboardPadding
            if #available(iOS 13, *) {
                scrollView.verticalScrollIndicatorInsets.bottom = newBottomInset
            } else {
                scrollView.scrollIndicatorInsets.bottom = newBottomInset
            }
        }

        animate(notification: notification, newBottomInsetPlusKeyboardPadding)
    }

    private func keyboardWillHide(_ notification: Notification) {
        if let scrollView = configuration?.view as? UIScrollView {
            // If you find that your view is jumping to the top of the view after you hide the keyboard:
            // 1. Go into your xib
            // 2. Select the view controller that contains the UIScrollView
            // 3. Go to Attributes Inspector
            // 4. Uncheck the option 'Adjust Scroll View Inset'
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero

            // Force invalidate the ScrollView
            scrollView.setContentOffset(scrollView.contentOffset, animated: true)
        }

        animate(notification: notification, 0)

        transparentTouchView.removeFromSuperview()
    }
}

#if swift(>=6.0)
extension KeyboardHandler: @unchecked Sendable {}

private struct UnsafeSendable<T>: @unchecked Sendable {
    let value: T

    init(_ value: T) {
        self.value = value
    }
}
#else
private struct UnsafeSendable<T> {
    let value: T

    init(_ value: T) {
        self.value = value
    }
}
#endif

#endif
