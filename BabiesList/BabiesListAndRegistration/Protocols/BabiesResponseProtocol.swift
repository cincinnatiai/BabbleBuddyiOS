//
//  BabiesResponseProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 6/16/25.
//

public protocol BabiesResponseProtocol {
    var accountProfile: AccountProfileProtocol? { get }
    var account: AccountProtocol? { get }
}
