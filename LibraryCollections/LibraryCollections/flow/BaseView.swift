import Foundation
import UIKit
import LibraryCollections

public protocol IBaseView:UIViewController {
    var contentView:UIView { get }
    func showLoading(container:UIView?, loadingW:CGFloat, loadingH:CGFloat)
    func closeLoading()
}

extension IBaseView {
    
    public var contentView:UIView { self.view }
    
    public func showLoading(container:UIView? = UIApplication.shared.windows[0].rootViewController?.view,
                            loadingW:CGFloat = 70, loadingH:CGFloat = 40) {
        guard let rootView = container else {
            return
        }
        // 使用RootView, 避免Static UITableViewController造成的偏移
        let imageUrl = Bundle.main.url(forResource: "loading", withExtension: "gif")!
        let loadingView = CustomLoadingView(frame: self.view.frame,
                                            imageUrl: imageUrl, msg: NSLocalizedString("Global.Loading", comment: ""),
                                            loadingW: loadingW,
                                            loadingH: loadingH)
        ViewUtils.showLoading(customLoadingView: loadingView, container: rootView)
    }
    public func closeLoading() {
        ViewUtils.closeLoading()
    }
}
