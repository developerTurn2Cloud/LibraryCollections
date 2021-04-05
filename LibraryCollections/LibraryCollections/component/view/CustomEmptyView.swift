import UIKit

@IBDesignable public class CustomEmptyView: UIView, NibLoadable  {

    @IBInspectable public var emptyIcon:UIImage = UIImage(named: "") {
        didSet {
            self.emptyImageView.image = self.emptyIcon
        }
    }
    
    @IBInspectable public var emptyTitle:String = "" {
        didSet {
            self.emptyLabel.text = self.emptyTitle
        }
    }
    
    @IBInspectable public var titleColor:UIColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1) {
        didSet {
            self.emptyLabel.textColor = titleColor
        }
    }
    
    
    @IBInspectable public var bgColor:UIColor = UIColor.white {
        didSet {
            self.contentView.backgroundColor = self.bgColor
        }
    }
    
    @IBOutlet public var contentView: UIView!
    @IBOutlet public weak var emptyImageView: UIImageView!
    @IBOutlet public weak var emptyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }

}
