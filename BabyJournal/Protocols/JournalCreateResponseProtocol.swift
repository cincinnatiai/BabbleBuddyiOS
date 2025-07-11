//
//  JournalCreateResponseProtocol.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

public protocol JournalCreateResponseProtocol{
    var partitionKey: String { get }
    var rangeKey: String { get }
    var type: String { get }
    var typeIndex: String { get }
    var unit: String { get }
    var quantity: Int { get }
    var body: String { get }
    var dayDate: String { get }
    var modified: String { get }
    var status: String { get }
    var userId: String { get }
    var file: String { get }
    var timezone: String { get }
}
