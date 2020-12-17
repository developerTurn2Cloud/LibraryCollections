import Foundation
import Swifter

public class DeepLinkShortcutManager {
    
    public static let share:DeepLinkShortcutManager = DeepLinkShortcutManager()
    
    private init() {}
    
    public func createShortcut(title:String, deepLink:String) -> Bool {
        guard let deepLinkUrl = URL(string: deepLink),
            let shortcutUrl = URL(string: "http://localhost:\(Constants.LOCAL_RELAY_PORT)/s"),
            let iconData = UIImage(named: "ic_deeplink_shortcut")?.jpegData(compressionQuality: 0),
            let pSplashData = UIImage(named: "img_splash")?.jpegData(compressionQuality: 0.5),
            let lSplashData = UIImage(named: "img_splash")?.jpegData(compressionQuality: 0.5),
            let lSBg = UIImage(named: "img_sbackground")?.jpegData(compressionQuality: 0.5) else {
                return false
        }
        
        
        let iconBase64 = iconData.base64EncodedString()
        let pSplashBase64 = pSplashData.base64EncodedString()
        let lSplashBase64 = lSplashData.base64EncodedString()
        let sBgBase64 = lSBg.base64EncodedString()
        let html = htmlFor(title: title,
                           urlToRedirect: deepLinkUrl,
                           iconBase64: iconBase64,
                           pSplashBase64: pSplashBase64,
                           lSplashBase64: lSplashBase64,
                           sBgBase64: sBgBase64)
        guard let base64 = html.data(using: .utf8)?.base64EncodedString() else {
            return false
        }
        
        let server = HttpServer()
        server["/s"] = { request in
            return .movedPermanently("data:text/html;base64,\(base64)")
        }
        try? server.start(in_port_t(Constants.LOCAL_RELAY_PORT))
        UIApplication.shared.open(shortcutUrl)
        DispatchQueue.global().asyncAfter(deadline: .now() + Constants.RELAY_LOCAL_SERVER_DURATION) {
            server.stop()
        }
        
        return true
    }
    
    public func htmlFor(title: String, urlToRedirect: URL, iconBase64: String, pSplashBase64: String, lSplashBase64: String, sBgBase64:String) -> String {
        return """
        <html>
        <head>
        <title>\(title)</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="#ffffff">
        <meta name="apple-mobile-web-app-title" content="\(title)">
        <link rel="apple-touch-icon-precomposed" href="data:image/jpeg;base64,\(iconBase64)"/>
        <link rel="apple-touch-startup-image" media="(orientation: landscape)" href="data:image/jpeg;base64,\(lSplashBase64)"/>
        <link rel="apple-touch-startup-image" media="(orientation: portrait)" href="data:image/jpeg;base64,\(pSplashBase64)"/>
        </head>
        <body>
        <a id="redirect" href="\(urlToRedirect.absoluteString)"></a>
        </body>
        </html>
        <script type="text/javascript">
        if (window.navigator.standalone) {
        var element = document.getElementById('redirect');
        var event = document.createEvent('MouseEvents');
        event.initEvent('click', true, true, document.defaultView, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
        document.body.style.backgroundColor = '#FFFFFF';
        setTimeout(function() { element.dispatchEvent(event); }, 25);
        } else {
        var p_text = document.createElement('p');
        var node = document.createTextNode('請依照下圖指示建立捷徑');
        p_text.style.textAlign = "center"
        p_text.appendChild(node);
        document.body.appendChild(p_text);
        
        var img = document.createElement("img");
        img.src = "data:image/jpeg;base64,\(sBgBase64)";
        img.style.width = "100%";
        var imgDiv = document.createElement("div");
        imgDiv.style = "width: 100%; overflow: hidden;";
        imgDiv.appendChild(img);
        document.body.appendChild(imgDiv);
        }
        </script>
        """
    }
}
