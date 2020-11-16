import Foundation
import UIKit

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0
    )
  {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
    
    func applyLayerAttribute(x: CGFloat = 0,
                             y: CGFloat = 2,
                             shadowR:CGFloat = 0,
                             shadowOpacity:Float = 0,
                             color:UIColor = .black) {
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowR
        self.shadowColor = color.cgColor
    }
}
