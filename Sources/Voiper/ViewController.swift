#if canImport(UIKit)

import UIKit

typealias TableViewController = TableViewControllerClass & ViewControllerType & StoryboardInstantiable
class TableViewControllerClass: UITableViewController, ViewControllerProtocol {
    var _presenter: PresenterProtocol?
    
    func set(presenter: PresenterProtocol) {
        self._presenter = presenter
    }
}

typealias ViewController = ViewControllerClass & ViewControllerType & StoryboardInstantiable
class ViewControllerClass: UIViewController, ViewControllerProtocol {
    var _presenter: PresenterProtocol?
    
    func set(presenter: PresenterProtocol) {
        self._presenter = presenter
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

protocol Parentable {
    associatedtype ChildIdentifier
    func addChildViewController(viewController: UIViewController, for identifier: ChildIdentifier)
    func removeChildViewController(for identifier: ChildIdentifier)
}

protocol ViewControllerProtocol: class {
    func set(presenter: PresenterProtocol)
}

protocol ViewControllerType {
    associatedtype PresenterType
    var _presenter: PresenterProtocol? {get}
    var presenter: PresenterType {get}
}

extension ViewControllerType {
    var presenter: PresenterType {
        return (_presenter as! PresenterType)
    }
}

#endif
