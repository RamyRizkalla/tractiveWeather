//Copyright © 2020 Tractive. All rights reserved.

import UIKit

extension UIImage {
    func dimmed(alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }

        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.translateBy(x: 0, y: -size.height)

        let rect = CGRect(origin: .zero, size: size)
        ctx.draw(cgImage, in: rect)
        UIColor(white: 0.0, alpha: alpha).setFill()
        ctx.fill(rect)
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
