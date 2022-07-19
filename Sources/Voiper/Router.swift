import UIKit

/// The typealias that compounds RouterClass and Injectable. To be inherited by the Router of a module
public typealias Router = RouterClass & Injectable
public typealias AsyncRouter = RouterClass & AsyncInjectable
open class RouterClass: RouterProtocol {
    public weak var viewController: UIViewController?
    
    public func set(viewController: UIViewController) {
        self.viewController = viewController
    }
    public init() {
    }
}

public protocol RouterProtocol: AnyObject {
    /// The reference of the View component of the VOIPER to be used for invoking the navigational and Parentable functions
    ///
    /// This property is optional as this needs to be weakly referenced, to avoid retain cycles. It may return nil, if at the time of access, the ViewController is already
    /// deallocated.
    var viewController: UIViewController? {get set}
    func set(viewController: UIViewController)
}

public extension RouterProtocol {
    func set(viewController: UIViewController) {
        self.viewController = viewController
    }
}
