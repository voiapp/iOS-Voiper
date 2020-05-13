import UIKit

public typealias Router = RouterClass & Injectable
open class RouterClass: RouterProtocol {
    public weak var viewController: UIViewController!
    
    public func set(viewController: UIViewController) {
        self.viewController = viewController
    }
    public init() {
    }
}

public protocol RouterProtocol: class {
    var viewController: UIViewController! {get set}
    func set(viewController: UIViewController)
}
