import SwiftUI

public extension View {
    @ViewBuilder
    func `if`(_ condition: Bool,
              content: (Self) -> some View,
              else elseContent: ((Self) -> some View)? = nil) -> some View {
        if condition {
            content(self)
        } else if let elseContent {
            elseContent(self)
        } else {
            self
        }
    }

    @ViewBuilder
    func `if`(_ condition: Bool,
              content: (Self) -> some View) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}
