import Foundation
import UIKit

public class ViewUtils {
    
    static var loadingView:BaseLoadingView? = nil
    
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
    
    public static func setRootPage(targetStoryboard:String, targetStoryboardId:String) {
        let targetVc = UIStoryboard(name: targetStoryboard, bundle: nil).instantiateViewController(withIdentifier: targetStoryboardId)
        
        ViewUtils.setRootPage(vc: targetVc)
    }
    
    public static func setRootPage(vc:UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    public static func showLoading<T:BaseLoadingView>(customLoadingView:T,
                                   container:UIView) {
        closeLoading()
        
        loadingView = customLoadingView
        loadingView?.showLoading(container: container)
    }
    
    public static func closeLoading() {
        loadingView?.closeLoading()
        loadingView = nil
    }
}

