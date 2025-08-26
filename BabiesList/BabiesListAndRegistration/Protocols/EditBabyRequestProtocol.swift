//
//  EditBabyRequestProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Cincinnati Ai on 8/25/25.
//

public protocol EditBabyRequestProtocol: Codable {
    var clientId: String { get }
    var created: String { get }
    var description: String { get }
    var metadata: String { get }
    var modified: String { get }
    var partitionKey: String { get }
    var rangeKey: String { get }
    var status: String { get }
    var title: String { get }
    var type: String { get }
}
