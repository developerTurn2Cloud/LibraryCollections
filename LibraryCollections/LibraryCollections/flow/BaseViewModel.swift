import Foundation

open protocol IBaseViewModel:class {
    func release()
}

extension IBaseViewModel {
    public func release() {}
}
