//
//  JournalDeleteRequestModel.swift
//  BabyJournal
//
//  Created by CincinnatiAI Dallas on 8/27/25.
//

public struct JournalDeleteRequestModel: Codable, JournalDeleteRequestProtocol {
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
