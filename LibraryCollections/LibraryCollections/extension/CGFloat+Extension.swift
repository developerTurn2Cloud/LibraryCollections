import Foundation
import UIKit

extension CGFloat {
    
    /// Random cg float
    public static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
