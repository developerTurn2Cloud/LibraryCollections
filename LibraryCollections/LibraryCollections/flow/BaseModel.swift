import Foundation
import Moya
import RxSwift

open class BaseModel {
    public let compositeDisposal:CompositeDisposable!
    
    public init() {
        self.compositeDisposal = CompositeDisposable()
    }
    
    public func release() {
        self.compositeDisposal.dispose()
    }
    
}
