import UIKit

public protocol IBaseCell {
    
    associatedtype DataType
    
    func setData(data:DataType?)
}
