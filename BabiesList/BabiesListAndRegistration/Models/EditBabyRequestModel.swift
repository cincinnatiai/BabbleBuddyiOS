//
//  EditBabyRequestModel.swift
//  BabiesListAndRegistration
//
//  Created by Cincinnati Ai on 8/25/25.
//

public struct EditBabyRequestModel: Codable, EditBabyRequestProtocol {
    public let clientId: String
    public let created: String
    public let description: String
    public let metadata: String
    public let modified: String
    public let partitionKey: String
    public let rangeKey: String
    public let status: String
    public let title: String
    public let type: String
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case created
        case description
        case metadata
        case modified
        case partitionKey = "partition_key"
        case rangeKey = "range_key"
        case status
        case title
        case type
    }
}
