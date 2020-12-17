import Foundation
import LocalAuthentication

public class AuthenticationManager {
    public static var share:AuthenticationManager = AuthenticationManager()
    
    public enum BiometricType {
        case none
        case touch
        case face
    }
    
    private init() {}
    
    public func biometricCheck(onSuccess:@escaping () -> ()
        , onFail:@escaping (Error?) -> ()
        , onComplete:@escaping () -> ()) {
        let type:AuthenticationManager.BiometricType = self.getSupportBiometricsType()
        let authContext = LAContext()
        
        if type == AuthenticationManager.BiometricType.touch || type == AuthenticationManager.BiometricType.face {
            // 設置取消按鈕標題
            authContext.localizedCancelTitle = "取消"
            // 描述使用身份辨識的原因
            let reason = "用以驗證使用者以進行登入"
            // 評估指定方案
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        print("Authentication Successful")
                        onSuccess()
                    } else {
                        print("Authentication Failed")
                        onFail(error)
                    }
                    onComplete()
                }
            }
        } else {
            print("Failed: No support biometry authentication")
        }
    }
    
    public func getSupportBiometricsType() -> BiometricType {
        let authContext = LAContext()
            if #available(iOS 11, *) {
                let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
                switch(authContext.biometryType) {
                case .touchID:
                    return .touch
                case .faceID:
                    return .face
                default:
                    return .none
                }
            } else {
                return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
            }
    }
}
