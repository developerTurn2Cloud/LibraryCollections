import Foundation
import UIKit

protocol IRadioTextFieldEvent {
    func onSelect(radioTextFieldItem:CustomRadioTextFieldItem)
}

class CustomRadioTextFieldItem: UIView, NibLoadable {
    
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            self.leftPaddingConstraint.constant = self.leftPadding
            updateConstraints()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0.0 {
        didSet {
            self.rightPaddingConstraint.constant = self.rightPadding
            updateConstraints()
        }
    }
    
    @IBInspectable var inputFontColor:UIColor = UIColor.black {
        didSet {
            self.inputTextField.textColor = self.inputFontColor
        }
    }
    
    @IBInspectable var inputFontSize:CGFloat = 0.0 {
        didSet {
            guard self.inputTextField != nil else {
                return
            }
            self.inputTextField.font = self.inputTextField.font?.withSize(self.inputFontSize)
        }
    }
    
    @IBInspectable var inputBorderW:CGFloat = 0.0  {
        didSet {
            self.inputTextField.layer.borderWidth = self.inputBorderW
        }
    }
    
    @IBInspectable var inputBorderRGB:UIColor = UIColor.gray {
        didSet {
            self.inputTextField.layer.borderColor = self.inputBorderRGB.cgColor
        }
    }
    
    @IBInspectable var inputCornerR:CGFloat = 0.0  {
        didSet {
            self.inputTextField.layer.cornerRadius = self.inputCornerR
        }
    }
    
    @IBInspectable var inputLeftPadding:CGFloat = 0.0 {
        didSet {
            self.inputTextField.leftPadding = self.inputLeftPadding
        }
    }
    
    @IBInspectable var inputRightPadding:CGFloat = 0.0 {
        didSet {
            self.inputTextField.rightPadding = self.inputRightPadding
        }
    }
    
    @IBInspectable var placehold:String = "" {
        didSet {
            self.inputTextField.placeholder = self.placehold
        }
    }
    
    @IBInspectable var maxTextLength:Int = 30 {
        didSet {
            self.inputTextField.maxTextLength = self.maxTextLength
        }
    }
    
    
    @IBInspectable var text:String {
        get {
            self.inputTextField.text ?? ""
        }
        
        set {
            self.inputTextField.text = newValue
        }
    }
    
    @IBInspectable var checkedImg:UIImage = UIImage() {
        didSet {
            // 重新觸發一次
            self.isChecked = self.isChecked ? true : false
        }
    }
    
    @IBInspectable var unCheckedImg:UIImage = UIImage() {
        didSet {
            // 重新觸發一次
            self.isChecked = self.isChecked ? true : false
        }
    }
    
    @IBInspectable var isChecked:Bool = false {
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
    
    @IBOutlet weak var selectionRadioImageView: UIImageView!
    @IBOutlet weak var inputTextField: CustomTextField!
    @IBOutlet weak var leftPaddingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPaddingConstraint: NSLayoutConstraint!
    
    var eventDelegate:IRadioTextFieldEvent?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        initView()
    }
    
    func initView() {}
    
    @IBAction func onRadioChecked(_ sender: Any) {
        self.eventDelegate?.onSelect(radioTextFieldItem: self)
    }
    
}
