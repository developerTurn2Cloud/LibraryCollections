import Foundation
import Toast_Swift

open class TestUtils {
    public static func printString(str:String) {
        print(str)
    }
    
    public static func showToast(view:UIView, msg:String) {
        view.makeToast(msg)
    }
}
