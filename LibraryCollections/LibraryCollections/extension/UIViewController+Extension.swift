import Foundation
import UIKit
import MessageUI

extension UIViewController {
    
    public var contentView:UIView { self.view }
    
    public func showLoading(loadingW:CGFloat = 70, loadingH:CGFloat = 40) {
        let imageUrl = Bundle.main.url(forResource: "loading", withExtension: "gif")!
        let loadingView = CustomLoadingView(frame: self.view.frame,
                                            imageUrl: imageUrl, msg: NSLocalizedString("Global.Loading", comment: ""),
                                            loadingW: loadingW,
                                            loadingH: loadingH)
        ViewUtils.showLoading(customLoadingView: loadingView, container: self.view)
    }
    
    public func closeLoading() {
        ViewUtils.closeLoading()
    }
    
    public func showAlert(title:String,
                   content:String,
                   conformTitle:String? = "Global.Confirm".localized,
                   confirmHandler:((UIAlertAction) -> Void)? = nil,
                   cancelTitle:String? = nil,
                   cancelHandler:((UIAlertAction) -> Void)? = nil) {
        let alert:UIAlertController = UIAlertController(title: title, message: content, preferredStyle: .alert)
        
        if cancelTitle != nil {
            let confirmHandler:UIAlertAction = UIAlertAction(title: conformTitle, style: .default, handler: confirmHandler)
            let cancelAction:UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler)
            
            alert.addAction(confirmHandler)
            alert.addAction(cancelAction)
        } else {
            let confirmHandler:UIAlertAction = UIAlertAction(title: conformTitle, style: .cancel, handler: confirmHandler)
            
            alert.addAction(confirmHandler)
        }
        
        self.presentController(vc: alert)
    }
    
    public func openShare(sharedObjects:[Any]) {
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.presentController(vc: activityViewController)
    }
    
    
    public func mailTo(recipients:[String], subject:String, message:String) {
        let mail = MFMailComposeViewController()
        mail.setToRecipients(recipients)
        mail.setSubject(subject)
        mail.setMessageBody(message, isHTML: false)
        
        self.presentController(vc: mail)
    }
    
    // MARK:- Navigation
    
    public func popController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func dismissController(completion:(() -> Void)? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func performSegue(segueId:String, sender:Any? = nil) {
        self.performSegue(withIdentifier: segueId, sender: sender)
    }
    
    public func pushController(storyboardName:String, storyboardId:String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId)
        
        self.pushController(vc: vc)
    }
    
    public func pushController(vc:UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func presentController(storyboardName:String, storyboardId:String, completion:(() -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId)
        
        self.presentController(vc: vc)
    }
    
    public func presentController(vc:UIViewController, completion:(() -> Void)? = nil) {
        self.present(vc, animated: true, completion: completion)
    }
}
