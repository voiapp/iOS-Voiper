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
