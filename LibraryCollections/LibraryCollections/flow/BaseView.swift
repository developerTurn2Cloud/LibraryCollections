import Foundation
import UIKit
import LibraryCollections

public protocol IBaseView:UIViewController {
    func showLoading()
    func closeLoading()
}

extension IBaseView {
    
    public func showLoading(container:UIView? = UIApplication.shared.windows[0].rootViewController?.view) {
        guard let rootView = container else {
            return
        }
        // 使用RootView, 避免Static UITableViewController造成的偏移
        let imageUrl = Bundle.main.url(forResource: "loading", withExtension: "gif")!
        let loadingView = CustomLoadingView(frame: self.view.frame, imageUrl: imageUrl, msg: NSLocalizedString("Global.Loading", comment: ""))
        ViewUtils.showLoading(customLoadingView: loadingView, container: rootView)
    }
    public func closeLoading() {
        ViewUtils.closeLoading()
    }
}
