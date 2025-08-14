//
//  BabyJournalEventReponseModel.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

import BabyJournal

struct BabyJournalEventResponseModel: BabyJournalEventResponseProtocol, Codable {
    let rawResults: [BabyEventModel]
    let lastRangeKey: String?

    var results: [BabyEventProtocol] {
        return rawResults
    }

    enum CodingKeys: String, CodingKey {
        case rawResults = "results"
        case lastRangeKey = "last_range_key"
    }
}
