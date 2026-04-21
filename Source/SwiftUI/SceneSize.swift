#if canImport(SwiftUI)
import SwiftUI

public extension View {
    /// Tracks the frame of the SwiftUI scene containing this view in the global
    /// coordinate space and publishes it through `EnvironmentValues.sceneSize`.
    ///
    /// This is what SwiftUI exposes via `GeometryProxy.frame(in: .global)` —
    /// useful when you want the size of the outermost SwiftUI container and
    /// don't care about the underlying `UIWindow`/`NSWindow`. For the actual
    /// platform window, use `trackWindowSize()`.
    func trackSceneSize() -> some View {
        modifier(SceneSizeModifier())
    }
}

// MARK: - EnvironmentValues

public extension EnvironmentValues {
    var sceneSize: CGRect {
        get { self[SceneSizeKey.self] }
        set { self[SceneSizeKey.self] = newValue }
    }
}

// MARK: - SceneSizeModifier

private struct SceneSizeKey: EnvironmentKey {
    static let defaultValue: CGRect = .zero
}

private struct SceneSizePreferenceKey: PreferenceKey {
    static let defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

private struct SceneSizeModifier: ViewModifier {
    @State
    private var size: CGRect = .zero

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SceneSizePreferenceKey.self, value: proxy.frame(in: .global))
                }
            )
            .onPreferenceChange(SceneSizePreferenceKey.self) { new in
                size = new
            }
            .environment(\.sceneSize, size)
    }
}
#endif
