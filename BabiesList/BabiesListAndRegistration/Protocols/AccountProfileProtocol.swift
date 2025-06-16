//
//  AccountProfileProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 6/16/25.
//

public protocol AccountProfileProtocol {
    var partitionKey: String? { get }
    var rangeKey: String? { get }
    var firstName: String? { get }
    var middleName: String? { get }
    var lastName: String? { get }
    var encryptedEmail: String? { get }
    var permissions: Int? { get }
    var created: String? { get }
    var modified: String? { get }
    var status: String? { get }
}
