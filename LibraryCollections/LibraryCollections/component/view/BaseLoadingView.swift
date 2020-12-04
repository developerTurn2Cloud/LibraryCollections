import Foundation
import UIKit

open class BaseLoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initLoadingContentView()
    }
    
    open func initLoadingContentView() {
        fatalError("initLoadingContentView has not been implemented")
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
