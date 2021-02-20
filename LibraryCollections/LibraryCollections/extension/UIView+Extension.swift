 import Foundation
 import UIKit
 
 extension UIView {
    
    @IBInspectable open var borderW:CGFloat  {
        get {
            self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable open var borderRGB:UIColor  {
        get {
            UIColor(cgColor:self.layer.borderColor ?? UIColor.gray.cgColor)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable open var cornerR:CGFloat  {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    /// Constrain 4 edges of `self` to specified `view`.
    public func edges(to view: UIView, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        ])
    }
    
    // Returns the first constraint with the given identifier, if available.
    ///
    /// - Parameter identifier: The constraint identifier.
    public func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        self.constraints.first { $0.identifier == identifier }
    }
 }
