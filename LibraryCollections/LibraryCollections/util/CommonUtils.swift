import Foundation
import CommonCrypto
import UIKit
import Alamofire

public class CommonUtils {
    
    // MARK: - Properties
    private static let jsonEncoder:JSONEncoder = JSONEncoder()
    private static let jsonDecorder:JSONDecoder = JSONDecoder()
    private static let dateFormatter:DateFormatter = DateFormatter()
    private static let networkManager:NetworkReachabilityManager? = NetworkReachabilityManager()
    
    // MARK: - JSON
    public static func getJsonEncoder() -> JSONEncoder {
        return jsonEncoder
    }
    
    public static func getJsonDecoder() -> JSONDecoder {
        return jsonDecorder
    }
    
    public static func getJsonData<Type:Codable>(data:Type) -> Data {
        return (try? jsonEncoder.encode(data)) ?? Data()
    }
    
    // MARK: - Date
    public static func convertDateToString(formatStr:String, date:Date) -> String {
        dateFormatter.dateFormat = formatStr
        return dateFormatter.string(from: date)
    }
    
    public static func convertStringToDate(formatStr:String, dateStr:String) -> Date {
        dateFormatter.dateFormat = formatStr
        return dateFormatter.date(from: dateStr) ?? Date()
    }
    
    public static func convertStringToDate(timezone:TimeZone? = TimeZone.current, dateStr:String, dateFormatStr:String, amSymbol:String? = nil, pmSymbol:String? = nil) -> Date? {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatStr
        dateFormatter.timeZone = timezone
        //        dateFormatter.locale = Locale.current
        dateFormatter.amSymbol = amSymbol ?? ""
        dateFormatter.pmSymbol = pmSymbol ?? ""
        return dateFormatter.date(from: dateStr)
    }
    
    public static func convertDateToString(timezone:TimeZone? = TimeZone.current, date:Date, targetDateFormatStr:String, amSymbol:String? = nil, pmSymbol:String? = nil) -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = targetDateFormatStr
        dateFormatter.timeZone = timezone
        //        dateFormatter.locale = Locale.current
        dateFormatter.amSymbol = amSymbol ?? ""
        dateFormatter.pmSymbol = pmSymbol ?? ""
        return dateFormatter.string(from: date)
    }
    
    // MARK: - UserDefault
    public static func writeToUserDefault<DataType:Codable>(key:String, data:DataType) {
        let userDefaultStand = UserDefaults.standard
        if data is Array<Any> {
            let data = try? jsonEncoder.encode(data)
            userDefaultStand.set(data, forKey: key)
        } else {
            userDefaultStand.set(data, forKey: key)
        }
        userDefaultStand.synchronize()
    }
    
    public static func readFromUserDefault<DataType:Codable>(key:String) -> DataType? {
        let userDefaultStand = UserDefaults.standard
        
        if DataType.self is String.Type {
            return userDefaultStand.string(forKey: key) as? DataType
        } else if DataType.self is Array<Any>.Type {
            return userDefaultStand.object(forKey: key) as? DataType
        } else {
            guard let rawData = userDefaultStand.data(forKey: key),
                let data = try? jsonDecorder.decode(DataType.self, from:rawData) else {
                    return nil
            }
            return data
        }
    }
    
    public static func clearUserDefault(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Encryption
    public static func convertToSha512(input: String) -> String {
        let data = input.data(using: .utf8) ?? Data()
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA512($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map({ String(format: "%02hhx", $0) }).joined(separator: "")
    }
    
    // MARK: - QR & Bar
    public static func generateQRCode(qrCode: String) -> UIImage? {
        let data = qrCode.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 5, y: 5)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    public static func generateBarCode(barcode: String) -> UIImage? {
        let data = barcode.data(using: .ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            if let ciImage = filter.outputImage {
                return UIImage(ciImage: ciImage)
            }
        }
        return nil
    }
    
    // MARK: - Network
    public static func getQueryStringParameter(url: String, keyStr: String, separator:String) -> String? {
        let params = url.components(separatedBy: separator)
        let matchParam = params.first { param -> Bool in
            return param.contains(keyStr)
        }
        return matchParam
    }
    
    public static func openUrl(urlStr:String) {
        guard let url = URL(string:urlStr), UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        // can open succeeded.. opening the url
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //MARK: - Global
    public static func openSettings() {
        let url = URL(string:UIApplication.openSettingsURLString)
        if UIApplication.shared.canOpenURL(url!){
            // can open succeeded.. opening the url
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    public static func isConnected() -> Bool {
        networkManager?.isReachable ?? true
    }
}
