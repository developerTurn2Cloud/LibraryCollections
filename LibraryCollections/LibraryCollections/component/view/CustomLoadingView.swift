import UIKit
import Kingfisher
import LibraryCollections

class CustomLoadingView: BaseLoadingView {
    
    var msg:String?
    var imageUrl:URL?
    
    init(frame: CGRect, imageUrl:URL, msg:String) {
        self.msg = msg
        self.imageUrl = imageUrl
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initLoadingContentView() {
        self.frame = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.backgroundColor =  UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6)
        
        let loadingImageView:UIImageView = {
            let loadingImageView = UIImageView()
            loadingImageView.frame = CGRect(x: self.center.x - 35, y: self.center.y - 20, width: 70, height: 40)
            loadingImageView.contentMode = .scaleAspectFill
            
            return loadingImageView
        } ()
        self.addSubview(loadingImageView)
        
        let label:UILabel = {
            let label:UILabel = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.frame = CGRect(x: 0,
                                 y: loadingImageView.frame.origin.y + loadingImageView.frame.size.height + 28,
                                 width: self.frame.width,
                                 height: label.font.lineHeight)
            label.text = self.msg ?? "Loading..."
            
            return label
        } ()
        self.addSubview(label)
        
        let url = self.imageUrl ?? Bundle.main.url(forResource: "loading", withExtension: "gif")!
        loadingImageView.kf.setImage(with: url)
        self.setNeedsLayout()
    }
}