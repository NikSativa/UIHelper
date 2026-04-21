#if canImport(SwiftUI)
import SwiftUI

public extension View {
    /// Tracks the bounds of the platform window (`UIWindow` / `NSWindow`) hosting
    /// this view and publishes them through `EnvironmentValues.windowSize`.
    ///
    /// Unlike `trackSceneSize()`, which reports the SwiftUI scene's global frame,
    /// this modifier reflects the actual host window's bounds — useful when your
    /// SwiftUI hierarchy is embedded in a UIKit/AppKit parent that is smaller
    /// than its window.
    ///
    /// On platforms without a native window (`watchOS`), the value stays `.zero`.
    func trackWindowSize() -> some View {
        modifier(WindowSizeModifier())
    }
}

// MARK: - EnvironmentValues

public extension EnvironmentValues {
    var windowSize: CGRect {
        get { self[WindowSizeKey.self] }
        set { self[WindowSizeKey.self] = newValue }
    }
}

// MARK: - WindowSizeModifier

private struct WindowSizeKey: EnvironmentKey {
    static let defaultValue: CGRect = .zero
}

private struct WindowSizeModifier: ViewModifier {
    @State
    private var size: CGRect = .zero

    func body(content: Content) -> some View {
        content
            .background(
                WindowSizeReader { new in
                    size = new
                }
                .frame(width: 0, height: 0)
                .hidden()
            )
            .environment(\.windowSize, size)
    }
}

// MARK: - Platform readers

#if canImport(UIKit) && !os(watchOS)
import UIKit

private struct WindowSizeReader: UIViewRepresentable {
    let onChange: (CGRect) -> Void

    func makeUIView(context: Context) -> WindowSizeReaderView {
        let view = WindowSizeReaderView()
        view.onChange = onChange
        return view
    }

    func updateUIView(_ uiView: WindowSizeReaderView, context: Context) {
        uiView.onChange = onChange
        uiView.emit()
    }
}

private final class WindowSizeReaderView: UIView {
    var onChange: ((CGRect) -> Void)?
    private var lastEmitted: CGRect = .zero

    override func didMoveToWindow() {
        super.didMoveToWindow()
        emit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        emit()
    }

    func emit() {
        let current = window?.bounds ?? .zero
        guard current != lastEmitted else {
            return
        }
        lastEmitted = current
        DispatchQueue.main.async { [onChange, current] in
            onChange?(current)
        }
    }
}

#elseif canImport(AppKit)
import AppKit

private struct WindowSizeReader: NSViewRepresentable {
    let onChange: (CGRect) -> Void

    func makeNSView(context: Context) -> WindowSizeReaderView {
        let view = WindowSizeReaderView()
        view.onChange = onChange
        return view
    }

    func updateNSView(_ nsView: WindowSizeReaderView, context: Context) {
        nsView.onChange = onChange
        nsView.emit()
    }
}

private final class WindowSizeReaderView: NSView {
    var onChange: ((CGRect) -> Void)?
    private var lastEmitted: CGRect = .zero
    private var observers: [NSObjectProtocol] = []

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        for token in observers {
            NotificationCenter.default.removeObserver(token)
        }
        observers.removeAll()

        if let window {
            let token = NotificationCenter.default.addObserver(
                forName: NSWindow.didResizeNotification,
                object: window,
                queue: .main
            ) { [weak self] _ in
                self?.emit()
            }
            observers.append(token)
        }
        emit()
    }

    func emit() {
        let current = window?.frame ?? .zero
        guard current != lastEmitted else {
            return
        }
        lastEmitted = current
        DispatchQueue.main.async { [onChange, current] in
            onChange?(current)
        }
    }
}

#else

private struct WindowSizeReader: View {
    let onChange: (CGRect) -> Void
    var body: some View {
        Color.clear
    }
}

#endif
#endif
