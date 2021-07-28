import Foundation
import Moya
import RxSwift

open class BaseModel {
    public let compositeDisposal:CompositeDisposable!
    
    public init() {
        self.compositeDisposal = CompositeDisposable()
    }
    
    open func release() {
        self.compositeDisposal.dispose()
    }
    
}
