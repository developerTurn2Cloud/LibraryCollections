import UIKit

public protocol IBaseCell:UITableViewCell {
    
    associatedtype DataType
    
    func setData(data:DataType?)
}
