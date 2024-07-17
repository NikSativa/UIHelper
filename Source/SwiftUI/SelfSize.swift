import Foundation
import SwiftUI

@available(iOS 15.0, *)
public extension View {
    func selfSizing(_ size: Binding<CGSize>) -> some View {
        modifier(SelfSizeModifier(size: size))
    }
}

@available(iOS 15.0, *)
private struct SelfSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

@available(iOS 15.0, *)
private struct SelfSizeModifier: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content.background {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SelfSizeKey.self, value: proxy.size)
                    .onPreferenceChange(SelfSizeKey.self) { new in
                        size = new
                    }
            }
        }
    }
}
