//
//  Injectable.swift
//  
//
//  Created by Mayur Deshmukh on 2020-07-27.
//

public protocol Injectable {
    associatedtype Configuration
    init(configuration: Configuration)
}

public protocol AsyncInjectable {
    associatedtype Configuration
    init(configuration: Configuration) async
}

extension Injectable where Configuration == Void {
    init() {
        self.init(configuration: ())
    }
}

extension AsyncInjectable where Configuration == Void {
    init() async {
        await self.init(configuration: ())
    }
}
