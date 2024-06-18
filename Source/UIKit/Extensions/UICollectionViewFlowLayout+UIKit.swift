#if canImport(UIKit) && os(iOS)
import UIKit

public extension UICollectionViewFlowLayout {
    func applyAutomaticDimension() {
        estimatedItemSize = Self.automaticSize
    }
}
#endif
