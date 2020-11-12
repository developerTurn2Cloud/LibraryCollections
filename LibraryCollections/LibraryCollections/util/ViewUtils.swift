import Foundation
import UIKit

class ViewUtils {
    
    static var loadingView:CustomLoadingView? = nil
    
    static func closeKeyboard<T>(obj:T) {
        var view:UIView? = nil
        if obj is SceneDelegate {
            let rootVC = (obj as! SceneDelegate).window?.rootViewController
            view = rootVC?.view
        } else if obj is UIApplication {
            let rootVC = (obj as! UIApplication).windows.first?.rootViewController
            view = rootVC?.view
        } else if obj is UIView {
            view = obj as? UIView
        }
        
        guard let v = view else {
            return
        }
        v.endEditing(true)
    }
    
    static func showLoading(container:UIView) {
        closeLoading()
        
        if loadingView == nil {
            loadingView = CustomLoadingView(frame: .zero)
        }
        loadingView?.showLoading(container: container)
    }
    
    static func closeLoading() {
        loadingView?.closeLoading()
        loadingView = nil
    }
}

