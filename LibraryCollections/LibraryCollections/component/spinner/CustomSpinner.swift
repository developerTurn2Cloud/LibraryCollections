import UIKit

protocol ISpinnerDelegate {
    func onSpinnerClick(spinner:CustomSpinner)
}

@IBDesignable class CustomSpinner: UIView, NibLoadable {
    
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            self.leftPaddingConstraint.constant = self.leftPadding
            updateConstraints()
        }
    }
    
    @IBInspectable var rightPadding:CGFloat = 0.0 {
        didSet {
            self.rightPaddingConstraint.constant = self.rightPadding
            updateConstraints()
        }
    }
    
    @IBInspectable override var borderW:CGFloat {
        didSet {
            self.layer.borderWidth = self.borderW
        }
    }
    
    @IBInspectable override var borderRGB:UIColor {
        didSet {
            self.layer.borderColor = borderRGB.cgColor
        }
    }
    
    @IBInspectable override var cornerR:CGFloat {
        didSet {
            self.layer.cornerRadius = self.cornerR
        }
    }
    
    @IBInspectable var textColor:UIColor = UIColor.black {
        didSet {
            self.textLabel.textColor = self.textColor
        }
    }
    
    @IBInspectable var textSize:CGFloat = 0.0 {
        didSet {
            guard self.textLabel != nil, self.placeholdLabel != nil else {
                return
            }
            self.textLabel.font = self.textLabel.font.withSize(self.textSize)
            self.placeholdLabel.font = self.placeholdLabel.font.withSize(self.textSize)
        }
    }
    
    @IBInspectable var dropDownImage:UIImage {
        get {
            return self.dropDownArrow.image ?? UIImage(named: "ic_blue_down")!
        }
        
        set {
            self.dropDownArrow.image = newValue
        }
    }
    
    @IBInspectable var text: String = "" {
        didSet {
            self.placeholdLabel.isHidden = (!text.isEmpty)
            self.textLabel.isHidden = (text.isEmpty)
            self.textLabel.text = self.text
        }
    }
    
    @IBInspectable var placehold: String = "" {
        didSet {
            self.textLabel.isHidden = (!placehold.isEmpty)
            self.placeholdLabel.isHidden = (placehold.isEmpty)
            self.placeholdLabel.text = self.placehold
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var dropDownArrow: UIImageView!
    @IBOutlet weak var placeholdLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var leftPaddingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPaddingConstraint: NSLayoutConstraint!
    
    var delegate:ISpinnerDelegate?
    
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
    
    func initView() {
        // 預設Font size
        self.textSize = 14.0
    }
    
    @IBAction func onSpinnerClicked(_ sender: Any) {
        self.delegate?.onSpinnerClick(spinner: self)
        print("onSpinnerClicked")
    }
    
}
