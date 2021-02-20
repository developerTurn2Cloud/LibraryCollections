import Foundation
import UIKit

extension UIViewController {
    
    public func showAlert(title:String,
                   content:String,
                   conformTitle:String? = NSLocalizedString("Global.Confirm", comment: ""),
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
        self.present(alert, animated: true, completion: nil)
    }
    
    public func openShare(sharedObjects:[Any]) {
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
