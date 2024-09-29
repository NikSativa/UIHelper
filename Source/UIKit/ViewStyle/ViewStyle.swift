#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
public protocol StyleProperty: Equatable, Sendable {}

@MainActor
public protocol ApplicableStyleProperty: StyleProperty {
    associatedtype ViewType
    func apply(to view: ViewType)
}

@MainActor
public struct ViewStyle<T: ApplicableStyleProperty>: Equatable {
    public let properties: [T]

    public init(_ properties: T...) {
        self.properties = properties
    }

    private init(_ properties: [T]) {
        self.properties = properties
    }

    public func apply(to view: T.ViewType) {
        for styleProperty in properties {
            styleProperty.apply(to: view)
        }
    }

    public static func +=(lhs: inout ViewStyle<T>, rhs: ViewStyle<T>) {
        lhs = ViewStyle<T>(lhs.properties + rhs.properties)
    }

    public static func +(lhs: ViewStyle<T>, rhs: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle<T>(lhs.properties + rhs.properties)
    }

    public static func +=(lhs: inout ViewStyle<T>, rhs: T) {
        lhs = ViewStyle<T>(lhs.properties + [rhs])
    }

    public static func +(lhs: ViewStyle<T>, rhs: T) -> ViewStyle<T> {
        return ViewStyle<T>(lhs.properties + [rhs])
    }

    public static func +(lhs: T, rhs: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle<T>([lhs] + rhs.properties)
    }
}

#endif
