
public typealias Presenter = PresenterClass & PresenterType & Injectable
open class PresenterClass: PresenterProtocol {
    public private(set) weak var _viewDelegate: ViewControllerProtocol?
    public private(set) var _interactor: InteractorProtocol?
    public private(set) var _router: RouterProtocol?
    
    public func set(viewDelegate: ViewControllerProtocol) {
        self._viewDelegate = viewDelegate
    }
    
    public func set(interactor: InteractorProtocol) {
        self._interactor = interactor
    }
    
    public func set(router: RouterProtocol) {
        self._router = router
    }
    
    public init() {
    }
}

public protocol PresenterProtocol {
    func set(viewDelegate: ViewControllerProtocol)
    func set(interactor: InteractorProtocol)
    func set(router: RouterProtocol)
}

public extension PresenterProtocol {
    func set(viewDelegate: ViewControllerProtocol) {}
    func set(interactor: InteractorProtocol) {}
    func set(router: RouterProtocol) {}
}

public protocol PresenterType {
    associatedtype ViewDelegateType
    associatedtype InteractorType
    associatedtype RouterType
    var _viewDelegate: ViewControllerProtocol? {get}
    var _interactor: InteractorProtocol? {get}
    var _router: RouterProtocol? {get}
    var viewDelegate: ViewDelegateType? {get}
    var interactor: InteractorType {get}
    var router: RouterType {get}
}

public extension PresenterType {
    var viewDelegate: ViewDelegateType? {
        return _viewDelegate as? ViewDelegateType
    }
    
    var interactor: InteractorType {
        return (_interactor as! InteractorType)
    }
    
    var router: RouterType {
        return (_router as! RouterType)
    }
}
