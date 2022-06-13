//
//  AsyncOrganiser.swift
//  
//
//  Created by David Jangdal on 2022-06-13.
//

import Foundation

public protocol AsyncOrganiser {
    associatedtype ViewController: ViewControllerProtocol & Instantiable
    associatedtype Interactor: InteractorProtocol & AsyncInjectable
    associatedtype Presenter: PresenterProtocol & AsyncInjectable
    associatedtype Router: RouterProtocol & AsyncInjectable
}

extension AsyncOrganiser {
    public static func createModule(presenterConfiguration: Presenter.Configuration,
                                    interactorConfiguration: Interactor.Configuration,
                                    routerConfiguration: Router.Configuration) async -> ViewController {
        let presenter = await Presenter.init(configuration: presenterConfiguration)
        let interactor = await Interactor.init(configuration: interactorConfiguration)
        let router = await Router.init(configuration: routerConfiguration)
        return wireUpModule(presenter: presenter, interactor: interactor, router: router)
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

extension AsyncOrganiser where Presenter.Configuration == Void {
    public static func createModule(interactorConfiguration: Interactor.Configuration, routerConfiguration: Router.Configuration) async -> ViewController {
        await wireUpModule(presenter: Presenter.init(configuration: ()),
                           interactor: Interactor.init(configuration: interactorConfiguration),
                           router: Router.init(configuration: routerConfiguration))
    }
}

extension AsyncOrganiser where Interactor.Configuration == Void {
    public static func createModule(presenterConfiguration: Presenter.Configuration, routerConfiguration: Router.Configuration) async -> ViewController {
        await wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                           interactor: Interactor.init(configuration: ()),
                           router: Router.init(configuration: routerConfiguration))
    }
}

extension AsyncOrganiser where Router.Configuration == Void {
    public static func createModule(presenterConfiguration: Presenter.Configuration, interactorConfiguration: Interactor.Configuration) async -> ViewController {
        await wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                           interactor: Interactor.init(configuration: interactorConfiguration),
                           router: Router.init(configuration: ()))
    }
}

extension AsyncOrganiser where Presenter.Configuration == Void, Interactor.Configuration == Void {
    public static func createModule(routerConfiguration: Router.Configuration) async -> ViewController {
        await wireUpModule(presenter: Presenter.init(configuration: ()),
                           interactor: Interactor.init(configuration: ()),
                           router: Router.init(configuration: routerConfiguration))
    }
}

extension AsyncOrganiser where Presenter.Configuration == Void, Router.Configuration == Void {
    public static func createModule(interactorConfiguration: Interactor.Configuration) async -> ViewController {
        await wireUpModule(presenter: Presenter.init(configuration: ()),
                           interactor: Interactor.init(configuration: interactorConfiguration),
                           router: Router.init(configuration: ()))
    }
}

extension AsyncOrganiser where Interactor.Configuration == Void, Router.Configuration == Void {
    public static func createModule(presenterConfiguration: Presenter.Configuration) async -> ViewController {
        await wireUpModule(presenter: Presenter.init(configuration: presenterConfiguration),
                           interactor: Interactor.init(configuration: ()),
                           router: Router.init(configuration: ()))
    }
}

extension AsyncOrganiser where Presenter.Configuration == Void, Interactor.Configuration == Void, Router.Configuration == Void {
    public static func createModule() async -> ViewController {
        await wireUpModule(presenter: Presenter.init(configuration: ()),
                           interactor: Interactor.init(configuration: ()),
                           router: Router.init(configuration: ()))
    }
}
