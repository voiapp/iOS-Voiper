import UIKit

public typealias TableViewController = TableViewControllerClass & ViewControllerType & StoryboardInstantiable & ViewControllerInitProtocol
open class TableViewControllerClass: UITableViewController, ViewControllerProtocol {
    public var _presenter: PresenterProtocol?
    
    public func set(presenter: PresenterProtocol) {
        self._presenter = presenter
    }
}

public typealias ViewController = ViewControllerClass & ViewControllerType & StoryboardInstantiable & ViewControllerInitProtocol
open class ViewControllerClass: UIViewController, ViewControllerProtocol {
    public var _presenter: PresenterProtocol?
    
    public func set(presenter: PresenterProtocol) {
        self._presenter = presenter
    }
}

public protocol ViewControllerProtocol: class {
    func set(presenter: PresenterProtocol)
}

public extension ViewControllerProtocol {
    func set(presenter: PresenterProtocol) {}
}

public protocol ViewControllerType {
    associatedtype PresenterType
    var _presenter: PresenterProtocol? {get}
    var presenter: PresenterType {get}
}

public extension ViewControllerType {
    var presenter: PresenterType {
        return (_presenter as! PresenterType)
    }
}
