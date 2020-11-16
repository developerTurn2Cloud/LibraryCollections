import Foundation
import UIKit

private var __maxLengths = [UITextField: Int]()

@IBDesignable extension UITextField {
    
    @IBInspectable public override var cornerR:CGFloat  {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable public override var borderW: CGFloat {
        get {
            self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return Int.max // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField, maxLen:Int) {
        let t = textField.text
        textField.text = String(t?.suffix(maxLength) ?? "")
    }
    
    @IBInspectable public var leftPadding:CGFloat {
        get {
            return self.leftView?.frame.width ?? 0
        }
        set {
            self.setLeftPaddingPoints(newValue)
        }
    }
    
    @IBInspectable public var rightPadding:CGFloat {
        get {
            return self.rightView?.frame.width ?? 0
        }
        set {
            self.setRightPaddingPoints(newValue)
        }
    }
    
    public func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    public func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
