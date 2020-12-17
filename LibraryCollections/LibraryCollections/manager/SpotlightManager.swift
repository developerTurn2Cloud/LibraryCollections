import Foundation
import CoreSpotlight
import MobileCoreServices

public class SpotlightManager {
    public static let shared:SpotlightManager = SpotlightManager()
    
//    private var searchableItems:[CSSearchableItem]
    
    private init() {
//        self.searchableItems = [CSSearchableItem]()
    }
    
    public func setupSearchContent(title:String, identifier:String, domainIdentifier:String, thumbnailURL:URL, contentDescription:String) {
        let attributeSet:CSSearchableItemAttributeSet = {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            attributeSet.keywords = [title, contentDescription]
            attributeSet.title = title
            attributeSet.contentDescription = contentDescription
            attributeSet.identifier = identifier
            attributeSet.relatedUniqueIdentifier = identifier
            
            return attributeSet
        }()
        let searchableItem = CSSearchableItem(uniqueIdentifier: identifier,
                                              domainIdentifier: domainIdentifier,
                                              attributeSet: attributeSet)
        
        CSSearchableIndex.default().indexSearchableItems([searchableItem]) { (error) -> Void in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
            }
    }
}
