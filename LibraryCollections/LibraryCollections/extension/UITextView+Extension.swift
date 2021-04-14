import Foundation
import UIKit

@IBDesignable extension UITextView {
    @IBInspectable public var leftPadding: CGFloat {
        get {
            self.textContainerInset.left
        }
        
        set {
            self.textContainerInset.left = newValue
        }
    }
    
    @IBInspectable public var rightPadding: CGFloat {
        get {
            self.textContainerInset.right
        }
        
        set {
            self.textContainerInset.right = newValue
        }
    }
    
    @IBInspectable public var topPadding: CGFloat {
        get {
            self.textContainerInset.top
        }
        
        set {
            self.textContainerInset.top = newValue
        }
    }
    
    @IBInspectable public var bottomPadding: CGFloat {
        get {
            self.textContainerInset.bottom
        }
        
        set {
            self.textContainerInset.bottom = newValue
        }
    }
}
