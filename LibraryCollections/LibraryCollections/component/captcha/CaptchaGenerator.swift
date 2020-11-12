import Foundation
import UIKit

public protocol FontDelegate {
    func generateCaptchaFont() -> UIFont
}

/// Captcha generator
public struct CaptchaGenerator {
    
    private let captchaLen:Int
    
    public let delegate:FontDelegate
    
    public init(captchaLen:Int, delegate:FontDelegate) {
        self.captchaLen = captchaLen
        self.delegate = delegate
    }
    
    ///Alpha numeric
    static private let alphaNumeric = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789"
    
    /// Current captcha text
    fileprivate var currentCaptchaText: String = ""
    
    /// Random text
    /// - Parameter length: number fo length
    static private func randomString(length: Int) -> String {
        return String((0..<length).map{ _ in alphaNumeric.randomElement()! })
    }
    
    /// attributed keys
    private var attributedKeys: [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.font: self.delegate.generateCaptchaFont(), NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    /// Generate Captcha
    mutating public func generate() -> NSAttributedString {
        let captcha = CaptchaGenerator.randomString(length: self.captchaLen)
        self.currentCaptchaText = captcha
        let dispCaptchaStr:String = {
            var dispCaptchaStr = ""
            captcha.forEach { ch in
                dispCaptchaStr.append("\(ch)  ")
            }
            return dispCaptchaStr
        } ()
        
        let attributed = NSMutableAttributedString(string: dispCaptchaStr)
        attributed.addAttributes(attributedKeys, range: NSRange(location: 0, length: dispCaptchaStr.count))
        
        return attributed
    }
    
    /// Is Matched
    /// - Parameters:
    ///   - text: text
    ///   - inCaseSensitive: is Case sensitive
    public func isMatched(text: String, inCaseSensitive: Bool = false ) -> Bool {
        return inCaseSensitive ? currentCaptchaText == text : currentCaptchaText.lowercased() == text.lowercased()
    }
}



