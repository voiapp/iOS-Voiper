#if canImport(UIKit)

typealias Router = RouterClass & Injectable
class RouterClass: RouterProtocol {
    weak var viewController: UIViewController!
    
    func set(viewController: UIViewController) {
        self.viewController = viewController
    }
}

protocol RouterProtocol: class {
    var viewController: UIViewController! {get set}
    func set(viewController: UIViewController)
}

#endif
