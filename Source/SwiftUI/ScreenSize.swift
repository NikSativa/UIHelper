#if canImport(SwiftUI)
import SwiftUI

public enum ScreenSize {
    case compact
    case large

    #if swift(>=6.0)
    @MainActor
    public static var defaultLimit: CGSize = .init(width: 400, height: 400)
    #else
    public static var defaultLimit: CGSize = .init(width: 400, height: 400)
    #endif
}

public extension View {
    func available(forWidthSize size: ScreenSize, limit: CGSize = ScreenSize.defaultLimit) -> some View {
        modifier(SizeViewModifier(expected: .width(size), limit: limit))
    }

    func available(forHeighSize size: ScreenSize, limit: CGSize = ScreenSize.defaultLimit) -> some View {
        modifier(SizeViewModifier(expected: .height(size), limit: limit))
    }

    func available(forWidthSize width: ScreenSize, heighSize height: ScreenSize, limit: CGSize = ScreenSize.defaultLimit) -> some View {
        modifier(SizeViewModifier(expected: .both(width, height), limit: limit))
    }
}

private struct SizeViewModifier: ViewModifier {
    enum Combination {
        case width(ScreenSize)
        case height(ScreenSize)
        case both(ScreenSize, ScreenSize)
    }

    @Environment(\.sceneSize)
    private var sceneSize

    private let expected: Combination
    private let limit: CGSize

    init(expected: Combination,
         limit: CGSize) {
        self.expected = expected
        self.limit = limit
    }

    func body(content: Content) -> some View {
        if isAvailable {
            content
        }
    }

    private var isAvailable: Bool {
        switch expected {
        case .width(let size):
            return size.isAvailable(for: sceneSize.width, limit: limit.width)
        case .height(let size):
            return size.isAvailable(for: sceneSize.height, limit: limit.height)
        case .both(let width, let height):
            return width.isAvailable(for: sceneSize.width, limit: limit.width)
                && height.isAvailable(for: sceneSize.height, limit: limit.height)
        }
    }
}

private extension ScreenSize {
    func isAvailable(for size: CGFloat, limit: CGFloat) -> Bool {
        switch self {
        case .compact:
            return size <= limit
        case .large:
            return size > limit
        }
    }
}
#endif
