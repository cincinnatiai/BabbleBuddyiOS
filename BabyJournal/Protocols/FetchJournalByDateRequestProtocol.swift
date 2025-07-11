//
//  FetchJournalByDateRequestProtocol.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

public protocol FetchJournalByDateRequestProtocol: Codable {
    var accountPartitionKey: String { get }
    var accountRangeKey: String { get }
    var userId: String { get }
    var date: String { get }
    var lastRangeKey: String { get }
}
