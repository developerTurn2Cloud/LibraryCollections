import Foundation

extension String {
    
    public var isPlural:Bool {
        let newStr = self.replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "-", with: "")
        
        return (Double(newStr) ?? 0) >= 2
    }
    
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    public var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    public func toHtml() -> String {
        """
        <html><header><meta charset="UTF-8"><style>img{max-width:100%;height:auto !important;width:100% !important;};</style></header><body style='margin:0; padding:10px; -webkit-text-size-adjust: 220%;'>\(self)</body></html>
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
}