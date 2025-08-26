//
//  DeleteBabyRequestModel.swift
//  BabiesListAndRegistration
//
//  Created by Cincinnati Ai on 8/25/25.
//

public struct DeleteBabyRequestModel: Codable, DeleteBabyRequestProtocol {
    public let isHardDelete: Bool
    public let partitionKey: String
    public let rangeKey: String
    public let userId: String
    
    enum CodingKeys: String, CodingKey {
        case isHardDelete = "is_hard_delete"
        case partitionKey = "partition_key"
        case rangeKey = "range_key"
        case userId = "user_id"
    }
}
