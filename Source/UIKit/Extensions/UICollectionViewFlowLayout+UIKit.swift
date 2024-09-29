#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
public extension UICollectionViewFlowLayout {
    func applyAutomaticDimension() {
        estimatedItemSize = Self.automaticSize
    }
}
#endif
