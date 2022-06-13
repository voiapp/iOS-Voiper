import UIKit

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
    var viewController: UIViewController? {get set}
    func set(viewController: UIViewController)
}

public extension RouterProtocol {
    func set(viewController: UIViewController) {
        self.viewController = viewController
    }
}
