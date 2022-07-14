//
//  Injectable.swift
//  
//
//  Created by Mayur Deshmukh on 2020-07-27.
//

/// `Injectable` gurantees a that any type conforming to this protocol, shall have an initializer taking all required parameters wrapped in a Configuration
public protocol Injectable {
    associatedtype Configuration
    init(configuration: Configuration)
}

public protocol AsyncInjectable {
    associatedtype Configuration
    init(configuration: Configuration) async
}

extension Injectable where Configuration == Void {
    /// Convenience initialiser when the Configuration of the Injectable is Void
    init() {
        self.init(configuration: ())
    }
}

extension AsyncInjectable where Configuration == Void {
    init() async {
        await self.init(configuration: ())
    }
}
