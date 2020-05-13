#if canImport(UIKit)

protocol Injectable {
    associatedtype Configuration
    init(configuration: Configuration)
}

protocol StoryboardInstantiable: UIViewController {
    static var storyboardName: String { get }
    static var viewControllerName: String { get }
    static func instantiateFromStoryboard() -> Self
}

extension StoryboardInstantiable {
    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as! Self
        return viewController
    }
}

extension StoryboardInstantiable {
    static var viewControllerName: String {
        String(describing: Self.self)
    }
}

protocol Organiser {
    associatedtype ViewController: ViewControllerProtocol & StoryboardInstantiable
    associatedtype Interactor: InteractorProtocol & Injectable
    associatedtype Presenter: PresenterProtocol & Injectable
    associatedtype Router: RouterProtocol & Injectable
}

extension Organiser {
    static func createModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: routerConfiguration))
    }
    
    private static func wireUpModule(presenter: Presenter, interactor: Interactor, router: Router) -> ViewController {
        let viewController = ViewController.instantiateFromStoryboard()
        presenter.set(viewDelegate: viewController)
        presenter.set(router: router)
        presenter.set(interactor: interactor)
        viewController.set(presenter: presenter)
        router.set(viewController: viewController)
        return viewController
    }
}

extension Organiser where Presenter.Configuration == Void {
    static func createModule(interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Interactor.Configuration == Void {
    static func createModule(presenterConfiguration: Presenter.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Router.Configuration == Void {
    static func createModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Presenter.Configuration == Void, Interactor.Configuration == Void {
    static func createModule(routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Presenter.Configuration == Void, Router.Configuration == Void {
    static func createModule(interactorConfiguration: Interactor.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Interactor.Configuration == Void, Router.Configuration == Void {
    static func createModule(presenterConfiguration: Presenter.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Presenter.Configuration == Void, Interactor.Configuration == Void, Router.Configuration == Void {
    static func createModule() -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: ()))
    }
}

#endif
