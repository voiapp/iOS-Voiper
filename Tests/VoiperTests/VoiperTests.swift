import XCTest
import Voiper

class TestOrganiser: Organiser {
    typealias ViewController = TestViewController
    typealias Interactor = TestInteractor
    typealias Presenter = TestPresenter
    typealias Router = TestRouter
}

protocol TestViewControllerProtocol: ViewControllerProtocol {}
final class TestViewController: ViewController, TestViewControllerProtocol {
    typealias PresenterType = TestPresenterProtocol
    static var storyboardName = "Test"
}

protocol TestInteractorProtocol: InteractorProtocol {}
final class TestInteractor: Interactor, TestInteractorProtocol {
    typealias Configuration = Void
    init(configuration: Void) {
    }
}

protocol TestPresenterProtocol: PresenterProtocol {}
final class TestPresenter: Presenter, TestPresenterProtocol {
    typealias ViewDelegateType = TestViewControllerProtocol
    typealias InteractorType = TestInteractorProtocol
    typealias RouterType = TestRouterProtocol
    
    typealias Configuration = Void
    init(configuration: Void) {
    }
}

protocol TestRouterProtocol: RouterProtocol {}
final class TestRouter: Router, TestRouterProtocol {
    typealias Configuration = Void
    init(configuration: Void) {
    }
}

class MockViewController: TestViewControllerProtocol {
}

class MockInteractor: TestInteractorProtocol {
}

class MockPresenter: TestPresenterProtocol {
}

class MockRouter: TestRouterProtocol {
    var viewController: UIViewController!
}
