
public typealias Interactor = InteractorClass & Injectable
public typealias AsyncInteractor = InteractorClass & AsyncInjectable

open class InteractorClass: InteractorProtocol {
    public init() {
    }
}

public protocol InteractorProtocol {}
