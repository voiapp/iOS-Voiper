
/// Typealias that compounds the InteractorClass and Injectable types. To be inherited by Interactor of the module.
public typealias Interactor = InteractorClass & Injectable

public typealias AsyncInteractor = InteractorClass & AsyncInjectable

/// Class that represents a concrete type conforming to InteractorProtocol.
open class InteractorClass: InteractorProtocol {
    public init() {
    }
}

/// Protocol to be used as type-constraint in the Organiser
public protocol InteractorProtocol {}
