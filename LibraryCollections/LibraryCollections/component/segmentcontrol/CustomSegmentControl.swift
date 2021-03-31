import Foundation
import UIKit

open class CustomSegmentControl:UISegmentedControl {
    public var textColor:UIColor = UIColor.black
    public var textSelectedColor:UIColor = UIColor.black
    public var textSize: CGFloat = 14.0
    
}

public extension CustomSegmentControl {
    @IBInspectable
    var segTextColor: UIColor{
        get {
            return self.textColor
        }
        set {
            self.textColor = newValue
            let unselectedAttributes = [NSAttributedString.Key.foregroundColor: self.textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.textSize)]
            self.setTitleTextAttributes(unselectedAttributes, for: .normal)
        }
    }
    
    @IBInspectable
    var segSelectedTextColor: UIColor{
        get {
            return self.textSelectedColor
        }
        set {
            self.textSelectedColor = newValue
            let unselectedAttributes = [NSAttributedString.Key.foregroundColor: self.textSelectedColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.textSize)]
            self.setTitleTextAttributes(unselectedAttributes, for: .selected)
        }
    }
    
    @IBInspectable
    var segTextSize: CGFloat {
        get {
            return self.textSize
        }
        set {
            self.textSize = newValue
            let unselectedAttributes = [NSAttributedString.Key.foregroundColor: self.textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.textSize)]
            self.setTitleTextAttributes(unselectedAttributes, for: .normal)
            self.setTitleTextAttributes(unselectedAttributes, for: .selected)
        }
    }
}
