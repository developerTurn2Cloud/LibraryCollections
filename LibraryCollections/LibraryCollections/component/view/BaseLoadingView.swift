import Foundation
import UIKit

public class BaseLoadingView: UIView {
    public init(frame: CGRect, imageUrl:URL, msg:String) {
        super.init(frame: frame)
        self.initLoadingContentView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initLoadingContentView() {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading(container:UIView) {
        self.center = container.center
        
        container.addSubview(self)
    }
    
    func closeLoading() {
        self.alpha = 1.0
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {  [weak self] in
            self?.alpha = 0.0
        }, completion: { [weak self] result in
            self?.removeFromSuperview()
        })
    }
}
