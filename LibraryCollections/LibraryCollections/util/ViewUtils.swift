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
        if #available(iOS 13, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
            keyWindow?.rootViewController = targetVc
        } else {
            UIApplication.shared.keyWindow?.rootViewController = targetVc
        }
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

