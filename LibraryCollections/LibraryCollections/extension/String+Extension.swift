import Foundation

extension String {
    
    public var isPlural:Bool {
        let newStr = self.replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "-", with: "")
        
        return (Double(newStr) ?? 0) >= 2
    }
    
    public var intValue:Int {
        Int(self) ?? 0
    }
    
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    public var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    public var isValidDonateFormat: Bool {
        self.count >= 3 && self.count <= 7
    }
    
    public var isValidEInvoiceFormat: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^/[\dA-Z0-9+-\.]{7}$").evaluate(with: self)
    }
    
    public func toHtml(textSizePercent:Int = 220) -> String {
        """
        <html><header><meta charset="UTF-8"><style>img{max-width:100%;height:auto !important;width:100% !important;};</style></header><body style='margin:0; padding:10px; -webkit-text-size-adjust: \(textSizePercent)%;'>\(self)</body></html>
        """
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    //將原始的url編碼轉為合法的url
    public func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //將編碼後的url轉換回原始的url
    public func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    public var localized:String {
        NSLocalizedString(self, comment: "")
    }
}
