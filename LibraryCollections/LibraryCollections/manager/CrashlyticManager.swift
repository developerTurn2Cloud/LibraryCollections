import Foundation
import FirebaseCrashlytics

public class CrashlyticManager {
    
    public static let shared:CrashlyticManager = CrashlyticManager()
    
    public func setCustomValue(value:Any?, key:String) {
        Crashlytics.crashlytics().setCustomValue(value ?? "", forKey: key)
    }
    
    public func setCustomLog(logMsg:String) {
        Crashlytics.crashlytics().log(logMsg)
    }
    
    public func setUserId(userId:String) {
        Crashlytics.crashlytics().setUserID(userId)
    }
    
    public func uploadError(error:Error) {
        Crashlytics.crashlytics().record(error: error)
    }
}
