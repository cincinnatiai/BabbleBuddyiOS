//
//  CreateBabyRequestProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 6/16/25.
//

public protocol CreateBabyRequestProtocol: Codable {
    var accountType: String { get }
    var clientId: String { get }
    var description: String { get }
    var email: String { get }
    var metadata: String { get }
    var title: String { get }
    var userId: String { get }
}
