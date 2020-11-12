import UIKit

@IBDesignable public class CustomTextField: UITextField, UITextFieldDelegate {
    
    @IBInspectable public var maxTextLength:Int = Int.max
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initView()
    }
    
    func initView() {
        self.delegate = self
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range:NSRange,
                          replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount) {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= self.maxTextLength
    }
    
}
