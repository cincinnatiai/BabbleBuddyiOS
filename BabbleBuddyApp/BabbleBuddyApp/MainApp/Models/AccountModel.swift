//
//  AccountModel.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation
import BabiesListAndRegistration

public struct AccountModel: Codable, AccountProtocol {
    public let partitionKey: String?
    public let rangeKey: String?
    public let title: String?
    public let description: String?
    public let metadata: String?
    public let type: String?
    public let created: String?
    public let modified: String?
    public let status: String?
    
    enum CodingKeys: String, CodingKey {
        case partitionKey = "partition_Key"
        case rangeKey = "range_key"
        case title
        case description
        case metadata
        case type
        case created
        case modified
        case status
    }
}
