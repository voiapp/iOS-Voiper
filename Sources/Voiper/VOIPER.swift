import UIKit

/// Instantiable is a protocol whose conformance allows Voiper to Instantiate the conforming UIViewController.
///
/// To be used when ViewController is developed programmatically instead of Storyboard. For ViewControllers designed in Storyboard, use StoryboardInstantiable.
/// If Xib is used the method could be overridden to provide initialisation through XIB
public protocol Instantiable: UIViewController {
    /// Method that returns instance of the conforming type
    ///
    /// The default implementation simply invokes the init method of the type. It can be overridden to provide any other initialisation behaviour.
    static func instantiate() -> Self
}

public extension Instantiable {
    static func instantiate() -> Self {
        return Self.init()
    }
}

/// StoryboardInstantiable is a protocol whose conformance allows Voiper to Instantiate the conforming UIViewController from Storyboard.
///
/// The default implementation uses storyboardName and ViewControllerName to instantiate the conforming ViewController.
/// Default implementation of StoryboardInstantiable.viewControllerName provides the name of the Type. This is used as Storyboard identifier. If your Storyboard
/// identifier is not the same as the name of the Type of the ViewController, override viewControllerName to provide the storyboard identifier.
///
/// **IMPORTANT:**
/// If the storyboardName does not have a corresponding storyboard file and/or does not contain a UIViewController or a subclass of UIViewController with
/// viewControllerName as it's storyboard identifier, it might result into crash. Thus important to have module creation tests.
public protocol StoryboardInstantiable: Instantiable {
    /// Name of the Storyboard file, that contains the conforming ViewController
    static var storyboardName: String { get }
    
    /// The storyboard identifier of the conforming ViewController. Default implementation takes name of the conforming Type as the Storyboard identifier.
    /// Override to provide custom identifier.
    static var viewControllerName: String { get }
    
    /// The default implementation uses storyboardName and ViewControllerName to instantiate the conforming ViewController.
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
    /// The method that creates a module, by instantiating and setting up all the VIPR components
    /// - Parameters:
    ///   - presenterConfiguration: Configuration of the Presenter of the module. Usually these are entities required for the module to function, passed
    ///   on by other modules
    ///   - interactorConfiguration: Configuration of the Interactor of the module. Usually these will be tuple of Services, required by the interactor to
    ///   serve the Presenter with required information
    ///   - routerConfiguration: Configuration of the Router of the module. Usually these will be a bag of dependencies required to initialise the
    ///   subsequent modules before navigating to them
    /// - Returns: ViewController object that has all the adjacent and subsequent VIPR components set.
    public static func createModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: routerConfiguration))
    }
    
    /// Function that sets the VIPR component to each other
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
    /// Convenience function that does not need Presenter.Configuration if it is Void
    public static func createModule(interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Interactor.Configuration == Void {
    /// Convenience function that does not need Presenter.Configuration if it is Void
    public static func createModule(presenterConfiguration: Presenter.Configuration, routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Router.Configuration == Void {
    /// Convenience function that does not need Router.Configuration if it is Void
    public static func createModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Presenter.Configuration == Void, Interactor.Configuration == Void {
    /// Convenience function that does not need Presenter.Configuration and Interactor.Configuration if they are Void
    public static func createModule(routerConfiguration: Router.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: routerConfiguration))
    }
}

extension Organiser where Presenter.Configuration == Void, Router.Configuration == Void {
    /// Convenience function that does not need Presenter.Configuration and Router.Configuration if they are Void
    public static func createModule(interactorConfiguration: Interactor.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: ()),
                            interactor: Interactor.init(configuration: interactorConfiguration),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Interactor.Configuration == Void, Router.Configuration == Void {
    /// Convenience function that does not need Interactor.Configuration and Router.Configuration if they are Void
    public static func createModule(presenterConfiguration: Presenter.Configuration) -> ViewController {
        return wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                            interactor: Interactor.init(configuration: ()),
                            router: Router.init(configuration: ()))
    }
}

extension Organiser where Presenter.Configuration == Void, Interactor.Configuration == Void, Router.Configuration == Void {
    /// Convenience function that does not need any parameters if Presenter.Configuration, Interactor.Configuration and Router.Configuration are Void
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
