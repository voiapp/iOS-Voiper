
/// The typealias that compounds PresenterClass, PresenterType and Injectable. To be inherited by the Presenter of a module
public typealias Presenter = PresenterClass & PresenterType & Injectable
public typealias AsyncPresenter = PresenterClass & PresenterType & AsyncInjectable
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

/// PresenterType describes what are the types of the adjecent components of the Presenter.
/// The adjacent component types being the Interactor, Router and the ViewDelegate
public protocol PresenterType {
    /// The type of the ViewDelegate for the Presenter conforming to PresenterType.
    /// The Presenter will know it's ViewDelegate only by this reference type
    associatedtype ViewDelegateType
    
    /// The type of the InteractorType for the Presenter conforming to PresenterType.
    /// The Presenter will know it's Interactor only by this reference type
    associatedtype InteractorType
    
    /// The type of the RouterType for the Presenter conforming to PresenterType.
    /// The Presenter will know it's Router only by this reference type
    associatedtype RouterType
    
    /// The **stored** reference of the ViewDelegate referred only as ViewControllerProtocol
    ///
    /// The type is only kept as ViewControllerProtocol because there is no compile time guarantee that the Organsier.ViewController will match
    /// Presenter.ViewDelegateType. Thus it is handled at runtime. For more understanding, refer default implementation of PresenterType.viewDelegate and
    /// Organiser.wireUpModule(presenter: interactor: router:)
    ///
    /// **IMPORTANT:**
    /// This property is Optional, as it needs to be referred weakly in the Presenter. It can be nil, if the ViewDelegate has been deallocated, but this can also be
    /// nil if the Organsier.ViewController does not match Presenter.ViewDelegateType. Hence highly advised to have a module creation unit test.
    var _viewDelegate: ViewControllerProtocol? {get}
    
    /// The **stored** reference of the Interactor referred only as InteractorProtocol
    ///
    /// The type is only kept as InteractorProtocol because there is no compile time guarantee that the Organsier.Interactor will match
    /// Presenter.InteractorType. Thus it is handled at runtime. For more understanding, refer default implementation of PresenterType.interactor and
    /// Organiser.wireUpModule(presenter: interactor: router:)
    ///
    /// **IMPORTANT:**
    /// This property is force-cast at run-time to Presenter.InteractorType. If the conformance is missing or mismatching, this will result into crash. Hence highly
    /// advised to have a module creation unit test.
    var _interactor: InteractorProtocol? {get}
    
    /// The **stored** reference of the Router referred only as RouterProtocol
    ///
    /// The type is only kept as RouterProtocol because there is no compile time guarantee that the Organsier.Router will match
    /// Presenter.RouterType. Thus it is handled at runtime. For more understanding, refer default implementation of PresenterType.router and
    /// Organiser.wireUpModule(presenter: interactor: router:)
    ///
    /// **IMPORTANT:**
    /// This property is force-cast at run-time to Presenter.RouterType. If the conformance is missing or mismatching, this will result into crash. Hence highly
    /// advised to have a module creation unit test.
    var _router: RouterProtocol? {get}
    
    /// The **computed** reference of  Presenter.ViewDelegateType optionally cast from ViewControllerProtocol
    ///
    /// **IMPORTANT:**
    /// This property is Optional, as it needs to be referred weakly in the Presenter. It can be nil, if the ViewDelegate has been deallocated, but this can also be
    /// nil if the Organsier.ViewController does not match Presenter.ViewDelegateType. Hence highly advised to have a module creation unit test.
    var viewDelegate: ViewDelegateType? {get}
    
    /// The **computed** reference of  Presenter.InteractorType forced cast from InteractorProtocol
    ///
    /// **IMPORTANT:**
    /// This property is force-cast at run-time to Presenter.InteractorType. If the conformance is missing or mismatching, this will result into crash. Hence highly
    /// advised to have a module creation unit test.
    var interactor: InteractorType {get}
    
    /// The **computed** reference of  Presenter.RouterType forced cast from RouterProtocol
    ///
    /// **IMPORTANT:**
    /// This property is force-cast at run-time to Presenter.RouterType. If the conformance is missing or mismatching, this will result into crash. Hence highly
    /// advised to have a module creation unit test.
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
