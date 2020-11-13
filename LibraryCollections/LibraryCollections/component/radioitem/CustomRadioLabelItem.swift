import UIKit

public protocol IRadioLabelEvent {
    func onSelect(radioLabelItem:CustomRadioLabelItem)
}

public class CustomRadioLabelItem: UIView, NibLoadable {
    
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
    
    @IBInspectable public var text: String = "" {
        didSet {
            self.radioLabel.text = self.text
        }
    }
    
    @IBInspectable public var fontSize:CGFloat = 0.0 {
        didSet {
            guard self.radioLabel != nil else {
                return
            }
            self.radioLabel.font = self.radioLabel.font?.withSize(self.fontSize)
        }
    }
    
    @IBInspectable public var fontColor:UIColor = UIColor.black {
        didSet {
            self.radioLabel.textColor = self.fontColor
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
        }
    }
    
    @IBOutlet public weak var leftPaddingConstraint: NSLayoutConstraint!
    @IBOutlet public weak var rightPaddingConstraint: NSLayoutConstraint!
    @IBOutlet public weak var radioLabel: UILabel!
    @IBOutlet public weak var selectionRadioImageView: UIImageView!
    
    public var eventDelegate:IRadioLabelEvent?
    
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
        self.eventDelegate?.onSelect(radioLabelItem: self)
    }
    
}
