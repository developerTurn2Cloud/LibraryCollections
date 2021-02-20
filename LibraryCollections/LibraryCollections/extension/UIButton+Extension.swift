import Foundation
import UIKit

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
}
