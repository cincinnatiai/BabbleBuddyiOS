//
//  JournalCreateRequestModel.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

import Foundation

public struct BabyJournalEventRequestModel: Encodable, Hashable, JournalCreateRequestProtocol {
    public let accountPartitionKey: String
    public let accountRangeKey: String
    public let body: String
    public let dayDate: String
    public let file: String
    public let quantity: Int
    public let timestamp: String
    public let type: String
    public let unit: String
    public let userId: String

    enum CodingKeys: String, CodingKey {
        case accountPartitionKey = "account_partition_key"
        case accountRangeKey = "account_range_key"
        case body
        case dayDate = "day_date"
        case file
        case quantity
        case timestamp
        case type
        case unit
        case userId = "user_id"
    }

    public init(
        accountPartitionKey: String,
        accountRangeKey: String,
        body: String,
        dayDate: String,
        file: String,
        quantity: Int,
        timestamp: String,
        type: String,
        unit: String,
        userId: String
    ) {
        self.accountPartitionKey = accountPartitionKey
        self.accountRangeKey = accountRangeKey
        self.body = body
        self.dayDate = dayDate
        self.file = file
        self.quantity = quantity
        self.timestamp = timestamp
        self.type = type
        self.unit = unit
        self.userId = userId
    }
}
