import Foundation
import UIKit

var btnShadowSpread: CGFloat = 0

@IBDesignable extension UIButton {
    
    // MARK:- Title padding
    @IBInspectable public var leftPadding:CGFloat {
        get {
            self.titleEdgeInsets.left
        }
        
        set {
            self.titleEdgeInsets.left = newValue
        }
    }
    
    @IBInspectable public var topPadding:CGFloat {
        get {
            self.titleEdgeInsets.top
        }
        
        set {
            self.titleEdgeInsets.top = newValue
        }
    }
    
    @IBInspectable public var rightPadding:CGFloat {
        get {
            self.titleEdgeInsets.right
        }
        
        set {
            self.titleEdgeInsets.right = newValue
        }
    }
    
    @IBInspectable public var bottomPadding:CGFloat {
        get {
            self.titleEdgeInsets.bottom
        }
        
        set {
            self.titleEdgeInsets.bottom = newValue
        }
    }
    
    // MARK:- Shadow
    @IBInspectable public var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable public var shadowOffset: CGPoint {
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        
    }
    
    @IBInspectable public var shadowBlur: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue / 2.0
        }
    }
    
    @IBInspectable public var shadowSpread: CGFloat {
        set {
            btnShadowSpread = newValue
            
            if btnShadowSpread == 0 {
                layer.shadowPath = nil
            } else {
                let dx = -btnShadowSpread
                let rect = bounds.insetBy(dx: dx, dy: dx)
                layer.shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
        
        get {
            btnShadowSpread
        }
    }
}
