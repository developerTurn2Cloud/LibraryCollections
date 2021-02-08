import Foundation
import Moya
import RxSwift

public class BaseModel {
    let compositeDisposal:CompositeDisposable!
    
    public init() {
        self.compositeDisposal = CompositeDisposable()
    }
    
    public func release() {
        self.compositeDisposal.dispose()
    }
    
}
