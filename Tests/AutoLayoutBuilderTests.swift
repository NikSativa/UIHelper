#if canImport(UIKit) && os(iOS)
import Foundation
import UIHelper
import UIKit
import XCTest

@MainActor
final class AutoLayoutBuilderTests: XCTestCase {
    private let view = UIView()
    private let subview = UIView()
    private var isOptional: Bool = .random()

    /// Sending main actor-isolated value of type 'XCTestCase' with later accesses to nonisolated context risks causing data races
    private func commonSetUp() {
        subview.enableConstraints()
        view.addSubview(subview)
        isOptional.toggle()
    }

    func test_builder() {
        commonSetUp()

        @AutoLayoutBuilder
        var constraintsResult: [NSLayoutConstraint] {
            subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            subview.heightAnchor.constraint(equalTo: view.heightAnchor)

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            isOptional ? subview.widthAnchor.constraint(equalTo: view.widthAnchor) : nil
            isOptional ? nil : subview.widthAnchor.constraint(equalTo: view.widthAnchor)

            if #available(iOS 13, *) {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            for _ in 0..<2 {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            [subview.heightAnchor.constraint(equalTo: view.heightAnchor)]
        }

        XCTAssertEqual(view.constraints.count, 0)
        XCTAssertEqual(constraintsResult.count, isOptional ? 11 : 10)
        XCTAssertNotEqual(view.constraints, constraintsResult)
        XCTAssertTrue(!constraintsResult.contains { $0.isActive })
    }

    func test_NSLayoutConstraint_activate() {
        commonSetUp()

        let constraintsResult = NSLayoutConstraint.activate {
            subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            subview.heightAnchor.constraint(equalTo: view.heightAnchor)

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            isOptional ? subview.widthAnchor.constraint(equalTo: view.widthAnchor) : nil
            isOptional ? nil : subview.widthAnchor.constraint(equalTo: view.widthAnchor)

            if #available(iOS 13, *) {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            for _ in 0..<2 {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            [subview.heightAnchor.constraint(equalTo: view.heightAnchor)]
        }

        XCTAssertEqual(view.constraints.count, isOptional ? 11 : 10)
        XCTAssertEqual(view.constraints, constraintsResult)
        XCTAssertTrue(!constraintsResult.contains { !$0.isActive })
    }

    func test_NSLayoutConstraint_combine() {
        commonSetUp()

        let constraintsResult = NSLayoutConstraint.combine {
            subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            subview.heightAnchor.constraint(equalTo: view.heightAnchor)

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            isOptional ? subview.widthAnchor.constraint(equalTo: view.widthAnchor) : nil
            isOptional ? nil : subview.widthAnchor.constraint(equalTo: view.widthAnchor)

            if #available(iOS 13, *) {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            for _ in 0..<2 {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            [subview.heightAnchor.constraint(equalTo: view.heightAnchor)]
        }

        XCTAssertEqual(view.constraints.count, 0)
        XCTAssertEqual(constraintsResult.count, isOptional ? 11 : 10)
        XCTAssertNotEqual(view.constraints, constraintsResult)
        XCTAssertTrue(!constraintsResult.contains { $0.isActive })
    }

    func test_AutoLayoutBuilder_activate() {
        commonSetUp()

        let constraintsResult = AutoLayoutBuilder.activate {
            subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            subview.heightAnchor.constraint(equalTo: view.heightAnchor)

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            isOptional ? subview.widthAnchor.constraint(equalTo: view.widthAnchor) : nil
            isOptional ? nil : subview.widthAnchor.constraint(equalTo: view.widthAnchor)

            if #available(iOS 13, *) {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            for _ in 0..<2 {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            [subview.heightAnchor.constraint(equalTo: view.heightAnchor)]
        }

        XCTAssertEqual(view.constraints.count, isOptional ? 11 : 10)
        XCTAssertEqual(view.constraints, constraintsResult)
        XCTAssertTrue(!constraintsResult.contains { !$0.isActive })
    }

    func test_AutoLayoutBuilder_combine() {
        commonSetUp()

        let constraintsResult = AutoLayoutBuilder.combine {
            subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            subview.heightAnchor.constraint(equalTo: view.heightAnchor)

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            if isOptional {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            } else {
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
                subview.widthAnchor.constraint(equalTo: view.widthAnchor)
            }

            isOptional ? subview.widthAnchor.constraint(equalTo: view.widthAnchor) : nil
            isOptional ? nil : subview.widthAnchor.constraint(equalTo: view.widthAnchor)

            if #available(iOS 13, *) {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            for _ in 0..<2 {
                subview.heightAnchor.constraint(equalTo: view.heightAnchor)
            }

            [subview.heightAnchor.constraint(equalTo: view.heightAnchor)]
        }

        XCTAssertEqual(view.constraints.count, 0)
        XCTAssertEqual(constraintsResult.count, isOptional ? 11 : 10)
        XCTAssertNotEqual(view.constraints, constraintsResult)
        XCTAssertTrue(!constraintsResult.contains { $0.isActive })
    }
}
#endif
