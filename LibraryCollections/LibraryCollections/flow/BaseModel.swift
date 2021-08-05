import Foundation
import Moya
import RxSwift

open class BaseModel {
    public let disposeBag:DisposeBag!
    
    public init() {
        self.disposeBag = DisposeBag()
    }
}
