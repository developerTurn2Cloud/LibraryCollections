import UIKit

protocol IRadioLabelEvent {
    func onSelect(radioLabelItem:CustomRadioLabelItem)
}

class CustomRadioLabelItem: UIView, NibLoadable {
    
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
    
    @IBInspectable var text: String = "" {
        didSet {
            self.radioLabel.text = self.text
        }
    }
    
    @IBInspectable var fontSize:CGFloat = 0.0 {
        didSet {
            guard self.radioLabel != nil else {
                return
            }
            self.radioLabel.font = self.radioLabel.font?.withSize(self.fontSize)
        }
    }
    
    @IBInspectable var fontColor:UIColor = UIColor.black {
        didSet {
            self.radioLabel.textColor = self.fontColor
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
        }
    }
    
    @IBOutlet weak var leftPaddingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPaddingConstraint: NSLayoutConstraint!
    @IBOutlet weak var radioLabel: UILabel!
    @IBOutlet weak var selectionRadioImageView: UIImageView!
    
    var eventDelegate:IRadioLabelEvent?
    
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
        self.eventDelegate?.onSelect(radioLabelItem: self)
    }
    
}
