//
//  JournalDeleteRequestProtocol.swift
//  BabyJournal
//
//  Created by CincinnatiAI Dallas on 8/27/25.
//

import Foundation

public protocol JournalDeleteRequestProtocol: Codable {
    var isHardDelete: Bool { get }
    var partitionKey: String { get }
    var rangeKey: String { get }
    var userId: String { get }
}
