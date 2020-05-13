import XCTest
@testable import Voiper

final class VoiperTests: XCTestCase {
    func testCreateTestModule() {
        let viewController = TestOrganiser.createModule()
        let presenter = viewController.presenter as! TestPresenter
        let router = presenter.router as! TestRouter
        let interactor = presenter.interactor as! TestInteractor
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(router)
    }
}

class TestOrganiser: Organiser {
    typealias ViewController = TestViewController
    typealias Interactor = TestInteractor
    typealias Presenter = TestPresenter
    typealias Router = TestRouter
}

protocol TestViewControllerProtocol {}
final class TestViewController: ViewController, TestViewControllerProtocol {
    typealias PresenterType = TestPresenterProtocol
    static var storyboardName = "Test"
    
    static func instantiateFromStoryboard() -> TestViewController { // Workaround since storyboards can't exist in package
        TestViewController()
    }
}

protocol TestInteractorProtocol {}
final class TestInteractor: Interactor, TestInteractorProtocol {
    typealias Configuration = Void
    required init(configuration: Void) {
    }
}

protocol TestPresenterProtocol {}
final class TestPresenter: Presenter, TestPresenterProtocol {
    typealias ViewDelegateType = TestViewControllerProtocol
    typealias InteractorType = TestInteractorProtocol
    typealias RouterType = TestRouterProtocol
    
    typealias Configuration = Void
    required init(configuration: Void) {
    }
}

protocol TestRouterProtocol {}
final class TestRouter: Router, TestRouterProtocol {
    typealias Configuration = Void
    required init(configuration: Void) {
    }
}
