import SwiftUI

public extension Notification.Name {
    static let WindowSizeDidChange = Notification.Name("WindowSizeDidChange")
}

public struct WindowSizeKey: EnvironmentKey {
    public static var defaultValue: CGRect = .zero
    public init() {}
}

// MARK: - EnvironmentValues

public extension EnvironmentValues {
    var windowSize: CGRect {
        get { self[WindowSizeKey.self] }
        set {
            let oldValue = windowSize
            if oldValue != newValue {
                self[WindowSizeKey.self] = newValue
                NotificationCenter.default.post(name: .WindowSizeDidChange,
                                                object: nil,
                                                userInfo: [
                                                    "oldValue": oldValue,
                                                    "newValue": newValue
                                                ])
            }
        }
    }
}

// MARK: - WindowSizeKeyModifier

public extension View {
    func trackWindowSize() -> some View {
        modifier(WindowSizeKeyModifier())
    }
}

private struct WindowSizeKeyModifier: ViewModifier {
    @Environment(\.windowSize) var windowSize

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let newSize = geometry.frame(in: .global)
            content.environment(\.windowSize, newSize)
        }
    }
}
