import Foundation
import Moya
import RxSwift

class BaseModel {
    let compositeDisposal:CompositeDisposable!
    
    init() {
        self.compositeDisposal = CompositeDisposable()
    }
    
    func release() {
        self.compositeDisposal.dispose()
    }
    
}
