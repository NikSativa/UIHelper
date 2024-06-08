import UIKit

@resultBuilder
public enum AutoLayoutBuilder {
    /// Builds an expression within the builder to support converting a constraint into the array this builder requires.
    public static func buildBlock(_ component: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        return component.flatMap { $0 }
    }

    /// Builds an expression within the builder to support converting an optional constraint into the array this builder requires.
    public static func buildExpression(_ expression: NSLayoutConstraint?) -> [NSLayoutConstraint] {
        if let expression {
            return [expression]
        }
        return []
    }

    /// Builds an expression within the builder to support converting a constraint into the array this builder requires.
    public static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        return [expression]
    }

    /// Builds an expression within the builder to support direct supply of an array..
    public static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return expression
    }

    /// Provides support for “if” statements in multi-statement closures, producing conditional constraints for the “then” branch.
    public static func buildEither(first component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return component
    }

    /// Provides support for “if-else” statements in multi-statement closures, producing conditional constraints for the “else” branch.
    public static func buildEither(second component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return component
    }

    /// Provides support for loops, producing constraints only when the condition evaluates to true.
    public static func buildArray(_ components: [[NSLayoutConstraint]]) -> [NSLayoutConstraint] {
        return components.flatMap { $0 }
    }

    /// Provides support for “if” statements in multi-statement closures, producing a constraint array that is applied only when the condition evaluates to true.
    public static func buildOptional(_ component: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
        return component ?? []
    }

    /// Provides support for “if” statements with `#available()` clauses in multi-statement closures, producing conditional constraints for the “then” branch, i.e. the conditionally-available branch.
    public static func buildLimitedAvailability(_ component: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return component
    }
}

public extension AutoLayoutBuilder {
    /// Activate the layouts defined in the result builder parameter `constraints`.
    @discardableResult
    static func activate(@AutoLayoutBuilder constraints: () -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.activate(constraints: constraints)
    }

    /// Combine the layouts defined in the result builder parameter `constraints`.
    static func combine(@AutoLayoutBuilder constraints: () -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return constraints()
    }
}

public extension NSLayoutConstraint {
    /// Activate the layouts defined in the result builder parameter `constraints`.
    @discardableResult
    static func activate(@AutoLayoutBuilder constraints: () -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = constraints()
        activate(constraints)
        return constraints
    }

    /// Combine the layouts defined in the result builder parameter `constraints`.
    static func combine(@AutoLayoutBuilder constraints: () -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return constraints()
    }
}
