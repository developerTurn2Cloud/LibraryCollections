import Foundation
import Moya
import Alamofire

class CustomSSLPinManager: Manager {
    
    static var shared:Manager!
    
    static func configure(apiDomain:String, certificate:String) {
        let serverTrustPolicyManager: CustomServerTrustPoliceManager? = CustomServerTrustPoliceManager(apiDomain: apiDomain, certificate: certificate)
        
        shared = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: serverTrustPolicyManager
        )
        shared.startRequestsImmediately = false
        
    }
}

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    
    private var apiDomain:String
    private var certificate:String
    
    init(apiDomain:String, certificate:String) {
        self.apiDomain = apiDomain
        self.certificate = certificate
        super.init(policies: [:])
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
