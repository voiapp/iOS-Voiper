
typealias Presenter = PresenterClass & PresenterType & Injectable
class PresenterClass: PresenterProtocol {
    weak var _viewDelegate: ViewControllerProtocol?
    var _interactor: InteractorProtocol?
    var _router: RouterProtocol?
    
    func set(viewDelegate: ViewControllerProtocol) {
        self._viewDelegate = viewDelegate
    }
    
    func set(interactor: InteractorProtocol) {
        self._interactor = interactor
    }
    
    func set(router: RouterProtocol) {
        self._router = router
    }
}

protocol PresenterProtocol {
    func set(viewDelegate: ViewControllerProtocol)
    func set(interactor: InteractorProtocol)
    func set(router: RouterProtocol)
}

protocol PresenterType {
    associatedtype ViewDelegateType
    associatedtype InteractorType
    associatedtype RouterType
    var _viewDelegate: ViewControllerProtocol? {get}
    var _interactor: InteractorProtocol? {get}
    var _router: RouterProtocol? {get}
    var viewDelegate: ViewDelegateType {get}
    var interactor: InteractorType {get}
    var router: RouterType {get}
}

extension PresenterType {
    var viewDelegate: ViewDelegateType {
        return (_viewDelegate as! ViewDelegateType)
    }
    
    var interactor: InteractorType {
        return (_interactor as! InteractorType)
    }
    
    var router: RouterType {
        return (_router as! RouterType)
    }
}
