//
//  AccountProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 6/16/25.
//

public protocol AccountProtocol {
    var partitionKey: String? { get }
    var rangeKey: String? { get }
    var title: String? { get }
    var description: String? { get }
    var metadata: String? { get }
    var type: String? { get }
    var created: String? { get }
    var modified: String? { get }
    var status: String? { get }
}
