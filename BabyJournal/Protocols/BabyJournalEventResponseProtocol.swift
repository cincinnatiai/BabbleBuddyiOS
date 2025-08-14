//
//  BabyJournalEventResponseProtocol.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

public protocol BabyJournalEventResponseProtocol: Codable{
    var results: [BabyEventProtocol] { get }
    var lastRangeKey: String? { get }
}
