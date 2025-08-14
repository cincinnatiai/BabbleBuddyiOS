//
//  JournalCreateRequestProtocol.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

public protocol JournalCreateRequestProtocol: Codable {
    var accountPartitionKey: String { get }
    var accountRangeKey: String { get }
    var body: String { get }
    var dayDate: String { get }
    var file: String { get }
    var quantity: Int { get }
    var timestamp: String { get }
    var type: String { get }
    var unit: String { get }
    var userId: String { get }
}
