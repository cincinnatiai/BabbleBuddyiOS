//
//  BabyEventModel.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

import BabyJournal

struct BabyEventModel: BabyEventProtocol, JournalCreateResponseProtocol {
    let partitionKey: String
    let rangeKey: String
    let type: String
    let typeIndex: String
    let unit: String
    let quantity: Int
    let body: String
    let dayDate: String
    let modified: String
    let status: String
    let userId: String
    let file: String
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case partitionKey = "partition_key"
        case rangeKey = "range_key"
        case type
        case typeIndex = "type_index"
        case unit
        case quantity
        case body
        case dayDate = "day_date"
        case modified
        case status
        case userId = "user_id"
        case file
        case timezone
    }
}
