import Foundation
import Moya
import Alamofire

public class CustomSSLPinManager: Manager {
    public static var shared:Manager!
    
    public static func configure(apiDomain:String, certificatesPath:String) {
        let serverTrustPolicyManager: CustomServerTrustPoliceManager? = CustomServerTrustPoliceManager(apiDomain: apiDomain, certificatesPath: certificatesPath)
        
        shared = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: serverTrustPolicyManager
        )
        shared.startRequestsImmediately = false
        
    }
}

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    
    private var certificatesPath:String = ""
    private var apiDomain:String = ""
    
    init(apiDomain:String, certificatesPath:String = "") {
        super.init(policies: [:])
        
        self.apiDomain = apiDomain
        self.certificatesPath = certificatesPath
    }
    
    //自訂信任協議
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        //如果網域符合
        if host.hasSuffix(self.apiDomain) {
            //從檔案資料夾取出憑證
            let filePath = Bundle.main.path(forResource: self.certificate, ofType: "der")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
            let certificate = SecCertificateCreateWithData(nil, data as CFData)!
            
            let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
                //進行比對的參數
                certificates: [certificate],
                validateCertificateChain: true,
                validateHost: true
            )
            return serverTrustPolicy
        }
        return .performDefaultEvaluation(validateHost: true)
    }
}
