
public typealias Presenter = PresenterClass & PresenterType & Injectable
open class PresenterClass: PresenterProtocol {
    private weak var viewDelegate: ViewControllerProtocol?
    private var interactor: InteractorProtocol?
    private var router: RouterProtocol?
    
    public func set(viewDelegate: ViewControllerProtocol) {
        self.viewDelegate = viewDelegate
    }
    
    public func set(interactor: InteractorProtocol) {
        self.interactor = interactor
    }
    
    public func set(router: RouterProtocol) {
        self.router = router
    }
    
    public init() {
    }
}

public protocol PresenterProtocol {
    func set(viewDelegate: ViewControllerProtocol)
    func set(interactor: InteractorProtocol)
    func set(router: RouterProtocol)
}

public protocol PresenterType {
    associatedtype ViewDelegateType
    associatedtype InteractorType
    associatedtype RouterType
    var viewDelegate: ViewDelegateType? {get}
    var interactor: InteractorType? {get}
    var router: RouterType? {get}
}

public extension PresenterType {
    var viewDelegate: ViewDelegateType? {
        return viewDelegate
    }

    var interactor: InteractorType? {
        return interactor
    }

    var router: RouterType? {
        return router
    }
}
