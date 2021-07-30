import UIKit

public protocol Instantiable: UIViewController {
    static func instantiate() -> Self
}

public extension Instantiable {
    static func instantiate() -> Self {
        return Self.init()
    }
}

public protocol StoryboardInstantiable: Instantiable {
    static var storyboardName: String { get }
    static var viewControllerName: String { get }
    static func instantiateFromStoryboard() -> Self
}

public extension StoryboardInstantiable {
    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as! Self
        return viewController
    }
    static var viewControllerName: String {
        String(describing: Self.self)
    }
    
    static func instantiate() -> Self {
        return instantiateFromStoryboard()
    }
}

public protocol Organiser {
    associatedtype ViewController: ViewControllerProtocol & Instantiable
    associatedtype Interactor: InteractorProtocol & Injectable
    associatedtype Presenter: PresenterProtocol & Injectable
    associatedtype Router: RouterProtocol & Injectable
}

extension Organiser {
    public static func createModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: routerConfiguration))
    }
    
    private static func wireUpModule(presenter: Presenter, interactor: Interactor, router: Router) -> ViewController {
        let viewController = ViewController.instantiate()
        presenter.set(viewDelegate: viewController)
        presenter.set(router: router)
        presenter.set(interactor: interactor)
        viewController.set(presenter: presenter)
        router.set(viewController: viewController)
        return viewController
    }
}

extension Organiser where Presenter.Configuration == Void {
    public static func createModule(interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Interactor.Configuration == Void {
    public static func createModule(presenterConfiguration: Presenter.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Router.Configuration == Void {
    public static func createModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Presenter.Configuration == Void, Interactor.Configuration == Void {
    public static func createModule(routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Presenter.Configuration == Void, Router.Configuration == Void {
    public static func createModule(interactorConfiguration: Interactor.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Interactor.Configuration == Void, Router.Configuration == Void {
    public static func createModule(presenterConfiguration: Presenter.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Presenter.Configuration == Void, Interactor.Configuration == Void, Router.Configuration == Void {
    public static func createModule() -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Presenter: Embeddable, ViewController: ViewControllerType {
    public static func createAsChildModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) -> (UIViewController, Presenter.ParentControllable) {
        let childViewController = wireUpModule(presenter: Presenter(configuration: presenterConfiguration),
                                               interactor: Interactor(configuration: interactorConfiguration),
                                               router: Router(configuration: routerConfiguration))
        guard let parentControllable = childViewController.presenter as? Presenter.ParentControllable else {
            // TODO: it should be fixed, we should think about how to handle it in the best way
            // make optional or throw error or smth else?
            fatalError("")
        }
        return (childViewController, parentControllable)
    }
}

extension Organiser where Presenter: Embeddable, ViewController: ViewControllerType, Presenter.Configuration == Void, Interactor.Configuration == Void, Router.Configuration == Void {
    public static func createAsChildModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) -> (UIViewController, Presenter.ParentControllable) {
        let childViewController = wireUpModule(presenter: Presenter(configuration: ()),
                                               interactor: Interactor(configuration: ()),
                                               router: Router(configuration: ()))
        guard let parentControllable = childViewController.presenter as? Presenter.ParentControllable else {
            // TODO: it should be fixed, we should think about how to handle it in the best way
            // make optional or throw error or smth else?
            fatalError("")
        }
        return (childViewController, parentControllable)
    }
}
