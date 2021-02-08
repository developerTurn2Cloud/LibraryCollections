import Foundation

public protocol IBaseViewModel:class {
    func release()
}

extension IBaseViewModel {
    public func release() {}
}
