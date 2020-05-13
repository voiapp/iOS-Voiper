#if canImport(UIKit)

typealias Interactor = InteractorClass & Injectable

class InteractorClass: InteractorProtocol {}

protocol InteractorProtocol {}

#endif
