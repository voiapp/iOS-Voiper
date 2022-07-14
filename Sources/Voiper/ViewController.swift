import UIKit

/// The typealias that compounds TableViewControllerClass, ViewControllerType and Instantiable.
///
/// This is to be inherited by the ViewController component when you need it to be a TableViewController
public typealias TableViewController = TableViewControllerClass & ViewControllerType & Instantiable
open class TableViewControllerClass: UITableViewController, ViewControllerProtocol {
    public var _presenter: PresenterProtocol?
    
    public func set(presenter: PresenterProtocol) {
        self._presenter = presenter
    }
}
/// The typealias that compounds ViewControllerClass, ViewControllerType and Instantiable. To be inherited by the ViewController component.
public typealias ViewController = ViewControllerClass & ViewControllerType & Instantiable
open class ViewControllerClass: UIViewController, ViewControllerProtocol {
    public var _presenter: PresenterProtocol?
    
    public func set(presenter: PresenterProtocol) {
        self._presenter = presenter
    }
}

public protocol ViewControllerProtocol: AnyObject {
    func set(presenter: PresenterProtocol)
}

public extension ViewControllerProtocol {
    func set(presenter: PresenterProtocol) {}
}

public protocol ViewControllerType {
    associatedtype PresenterType
    
    /// The **stored** reference of the Presenter referred only as PresenterProtocol
    ///
    /// The type is only kept as PresenterProtocol because there is no compile time guarantee that the Organsier.Presenter will match
    /// ViewController.PresenterType. Thus it is handled at runtime. For more understanding, refer default implementation of ViewControllerType.presenter and
    /// Organiser.wireUpModule(presenter: interactor: router:)
    ///
    /// **IMPORTANT:**
    /// This property is force-cast at run-time to ViewControllerType.PresenterType. If the conformance is missing or mismatching, this will result into crash.
    /// Hence highly advised to have a module creation unit test.
    var _presenter: PresenterProtocol? {get}
    
    /// The **computed** reference of  ViewController.PresenterType optionally cast from PresenterProtocol
    ///
    /// **IMPORTANT:**
    /// This property is force-cast at run-time to ViewController.PresenterType . If the conformance is missing or mismatching, this will result into crash. Hence highly
    /// advised to have a module creation unit test.
    var presenter: PresenterType {get}
}

public extension ViewControllerType {
    var presenter: PresenterType {
        return (_presenter as! PresenterType)
    }
}
