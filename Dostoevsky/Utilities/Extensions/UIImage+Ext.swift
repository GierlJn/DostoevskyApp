import UIKit

extension UIImage {
    static func loadImages(_ imageNames: [String]) -> [UIImage] {
        var images = [UIImage]()
        for name in imageNames {
            if let image = UIImage(named: name) {
                images.append(image)
            }
        }
        return images
    }
}
