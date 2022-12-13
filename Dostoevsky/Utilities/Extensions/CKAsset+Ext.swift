import CloudKit
import UIKit

extension CKAsset {
    func convertToUIImage() -> UIImage {
        let placeholder = PlaceholderImage.banner

        guard let fileUrl = fileURL else { return placeholder }
        do {
            let data = try Data(contentsOf: fileUrl)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
