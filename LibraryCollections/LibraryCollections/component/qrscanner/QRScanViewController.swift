import UIKit

protocol IQRScanEvent:class {
    func onScanResult(code:String?, error:Error?)
}

class QRScanViewController: UIViewController {
    
    var qrReaderView:QRScannerView!
    @IBOutlet weak var qrReaderContentView: UIView!
    @IBOutlet weak var flashlightImageView: UIImageView!
    
    var isFlashlightToggled:Bool = false
    weak var eventDelegate:IQRScanEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.qrReaderView = {
            let qrReaderView = QRScannerView(frame: view.bounds)
            
            self.qrReaderContentView.addSubview(qrReaderView)
            qrReaderView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
            qrReaderView.startRunning()
            return qrReaderView
        }()
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.qrReaderView.stopRunning()
        self.qrReaderView.setTorchActive(isOn: false)
    }
    
    // MARK:- onFlashlightTaped
    @IBAction func onFlashlightTaped(_ sender: Any) {
        self.isFlashlightToggled = !self.isFlashlightToggled
        self.flashlightImageView.tintColor = self.isFlashlightToggled ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        self.qrReaderView.setTorchActive(isOn: self.isFlashlightToggled)
    }
}

extension QRScanViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure qrError: QRScannerError) {
        let qrError = qrError as NSError
        let error = NSError(domain: qrError.domain, code: qrError.code, userInfo: nil)
        
        self.onBackClicked(self)
        self.eventDelegate?.onScanResult(code: nil, error: error)
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        self.onBackClicked(self)
        self.eventDelegate?.onScanResult(code: code, error: nil)
    }
}
