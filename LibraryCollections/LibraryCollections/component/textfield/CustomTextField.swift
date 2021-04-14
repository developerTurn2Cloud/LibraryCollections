import Foundation
import UIKit

@IBDesignable open class CustomTextField:UITextField {
    
    var clearBtnBounds = CGRect(x: 0, y: 0, width: 20, height: 20)
    
    @IBInspectable public var clrBtnX: CGFloat = 0.0 {
        didSet {
            
            self.clearBtnBounds = CGRect(x: self.clrBtnX,
                                         y: self.clrBtnY,
                                         width: self.clrBtnW,
                                         height: self.clrBtnH)
        }
    }
    
    @IBInspectable public var clrBtnY: CGFloat = 0.0 {
        didSet {
            self.clearBtnBounds = CGRect(x: self.clrBtnX,
                                         y: self.clrBtnY,
                                         width: self.clrBtnW,
                                         height: self.clrBtnH)
        }
    }
    
    @IBInspectable public var clrBtnW: CGFloat = 0.0 {
        didSet {
            self.clearBtnBounds = CGRect(x: self.clrBtnX,
                                         y: self.clrBtnY,
                                         width: self.clrBtnW,
                                         height: self.clrBtnH)
        }
    }
    
    @IBInspectable public var clrBtnH: CGFloat = 0.0  {
        didSet {
            self.clearBtnBounds = CGRect(x: self.clrBtnX,
                                         y: self.clrBtnY,
                                         width: self.clrBtnW,
                                         height: self.clrBtnH)
        }
    }
    
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        self.clearBtnBounds = CGRect(x: self.frame.width - self.clrBtnX,
                                     y: self.frame.height / 2 - self.clrBtnY,
                                     width: self.clrBtnW,
                                     height: self.clrBtnH)
        return clearBtnBounds
    }
}
