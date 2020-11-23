import Foundation
import FirebaseCrashlytics

class CrashlyticManager {
    
    static let shared:CrashlyticManager = CrashlyticManager()
    
    func setCustomValue(value:Any?, key:String) {
        Crashlytics.crashlytics().setCustomValue(value ?? "", forKey: key)
    }
    
    func setCustomLog(logMsg:String) {
        Crashlytics.crashlytics().log(logMsg)
    }
    
    func setUserId(userId:String) {
        Crashlytics.crashlytics().setUserID(userId)
    }
    
    func uploadError(error:Error) {
        Crashlytics.crashlytics().record(error: error)
    }
}
