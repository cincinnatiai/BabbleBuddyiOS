//
//  DeleteBabyRequestProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Cincinnati Ai on 8/25/25.
//

public protocol DeleteBabyRequestProtocol: Codable {
    var isHardDelete: Bool { get }
    var partitionKey: String { get }
    var rangeKey: String { get }
    var userId: String { get }
}
