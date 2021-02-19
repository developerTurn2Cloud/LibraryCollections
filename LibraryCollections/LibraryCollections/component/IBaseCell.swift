import UIKit

protocol IBaseCell:UITableViewCell {
    
    associatedtype DataType
    
    func setData(data:DataType?)
}
