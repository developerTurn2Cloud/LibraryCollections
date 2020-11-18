import Foundation
import UIKit

public class ViewUtils {
    
    static var loadingView:CustomLoadingView? = nil
    
    public static func closeKeyboard<T>(obj:T) {
        var view:UIView? = nil
        if #available(iOS 13, *), obj is UIWindowSceneDelegate {
            let rootVC = (obj as! UIWindowSceneDelegate).window??.rootViewController
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
    
    public static func showLoading(container:UIView, imageUrl:URL, msg:String) {
        closeLoading()
        
        loadingView = CustomLoadingView(frame: .zero, imageUrl: imageUrl, msg: msg)
        loadingView?.showLoading(container: container)
    }
    
    public static func closeLoading() {
        loadingView?.closeLoading()
        loadingView = nil
    }
}
