import UIKit

public protocol NibLoadable where Self: UIView {

    /// Setup this view with nib:
    /// 1. Load content view from nib (with the class name)
    /// 2. Set owner to self
    /// 3. Add it as a subview and fill edges with AutoLayout
    func fromNib() -> UIView?
}

public extension NibLoadable {
    @discardableResult
    func fromNib() -> UIView? {
        let bundle = Bundle(for: self.classForCoder)
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let contentView = nib.instantiate(withOwner: self, options: nil)
        self.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.edges(to: self)
        return contentView
    }
}
