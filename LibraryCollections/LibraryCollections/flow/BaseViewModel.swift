import Foundation

public protocol IBaseViewModel:class {
    public func release()
}

public extension IBaseViewModel {
    public func release() {}
}
