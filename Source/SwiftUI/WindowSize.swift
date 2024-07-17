#if canImport(SwiftUI)
import SwiftUI

public extension View {
    func trackWindowSize() -> some View {
        modifier(WindowSizeKeyModifier())
    }
}

// MARK: - EnvironmentValues

public extension EnvironmentValues {
    var windowSize: CGRect {
        get { self[WindowSizeKey.self] }
        set {
            let oldValue = windowSize
            if oldValue != newValue {
                self[WindowSizeKey.self] = newValue
            }
        }
    }
}

// MARK: - WindowSizeKeyModifier

private struct WindowSizeKey: EnvironmentKey {
    static var defaultValue: CGRect = .zero
}

private struct WindowSizeKeyModifier: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let newSize = geometry.frame(in: .global)
            content.environment(\.windowSize, newSize)
        }
    }
}
#endif
