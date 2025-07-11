//
//  JournalRequestModel.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

struct JournalRequestModel: FetchJournalByDateRequestProtocol{
    let accountPartitionKey: String
    let accountRangeKey: String
    let userId: String
    let date: String
    let lastRangeKey: String

    enum CodingKeys: String, CodingKey {
        case accountPartitionKey = "account_partition_key"
        case accountRangeKey = "account_range_key"
        case userId = "user_id"
        case date
        case lastRangeKey = "last_range_key"
    }
}
