import Foundation
import UIKit

public protocol IRadioTextFieldEvent {
    func onSelect(radioTextFieldItem:CustomRadioTextFieldItem)
}

public class CustomRadioTextFieldItem: UIView, NibLoadable {
    
    @IBInspectable public var leftPadding: CGFloat = 0.0 {
        didSet {
            self.leftPaddingConstraint.constant = self.leftPadding
            updateConstraints()
        }
    }
    
    @IBInspectable public var rightPadding: CGFloat = 0.0 {
        didSet {
            self.rightPaddingConstraint.constant = self.rightPadding
            updateConstraints()
        }
    }
    
    @IBInspectable public var inputFontColor:UIColor = UIColor.black {
        didSet {
            self.inputTextField.textColor = self.inputFontColor
        }
    }
    
    @IBInspectable public var inputFontSize:CGFloat = 0.0 {
        didSet {
            guard self.inputTextField != nil else {
                return
            }
            self.inputTextField.font = self.inputTextField.font?.withSize(self.inputFontSize)
        }
    }
    
    @IBInspectable public var inputBorderW:CGFloat = 0.0  {
        didSet {
            self.inputTextField.layer.borderWidth = self.inputBorderW
        }
    }
    
    @IBInspectable public var inputBorderRGB:UIColor = UIColor.gray {
        didSet {
            self.inputTextField.layer.borderColor = self.inputBorderRGB.cgColor
        }
    }
    
    @IBInspectable public var inputCornerR:CGFloat = 0.0  {
        didSet {
            self.inputTextField.layer.cornerRadius = self.inputCornerR
        }
    }
    
    @IBInspectable public var inputLeftPadding:CGFloat = 0.0 {
        didSet {
            self.inputTextField.leftPadding = self.inputLeftPadding
        }
    }
    
    @IBInspectable public var inputRightPadding:CGFloat = 0.0 {
        didSet {
            self.inputTextField.rightPadding = self.inputRightPadding
        }
    }
    
    @IBInspectable public var placehold:String = "" {
        didSet {
            self.inputTextField.placeholder = self.placehold
        }
    }
    
    @IBInspectable public var maxTextLength:Int = 30 {
        didSet {
            self.inputTextField.maxTextLength = self.maxTextLength
        }
    }
    
    
    @IBInspectable public var text:String {
        get {
            self.inputTextField.text ?? ""
        }
        
        set {
            self.inputTextField.text = newValue
        }
    }
    
    @IBInspectable public var checkedImg:UIImage = UIImage() {
        didSet {
            // 重新觸發一次
            self.isChecked = self.isChecked ? true : false
        }
    }
    
    @IBInspectable public var unCheckedImg:UIImage = UIImage() {
        didSet {
            // 重新觸發一次
            self.isChecked = self.isChecked ? true : false
        }
    }
    
    @IBInspectable public var isChecked:Bool = false {
        didSet {
            self.selectionRadioImageView.image = self.isChecked ? self.checkedImg : self.unCheckedImg
            
            if self.isChecked {
                self.inputTextField.isEnabled = true
                self.inputTextField.borderW = 1.0
                self.inputTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                self.inputTextField.isEnabled = false
                self.inputTextField.borderW = 0.0
                self.inputTextField.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak public var selectionRadioImageView: UIImageView!
    @IBOutlet weak public var inputTextField: CustomTextField!
    @IBOutlet weak public var leftPaddingConstraint: NSLayoutConstraint!
    @IBOutlet weak public var rightPaddingConstraint: NSLayoutConstraint!
    
    public var eventDelegate:IRadioTextFieldEvent?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        initView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        initView()
    }
    
    func initView() {}
    
    @IBAction func onRadioChecked(_ sender: Any) {
        self.eventDelegate?.onSelect(radioTextFieldItem: self)
    }
    
}
