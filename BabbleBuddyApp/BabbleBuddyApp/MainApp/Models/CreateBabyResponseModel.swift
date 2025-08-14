//
//  CreateBabyResponseModel.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 6/15/25.
//

import BabiesListAndRegistration

public struct CreateBabyResponseModel: CreateBabyResponseProtocol, Decodable {
    public let partitionKey: String
    public let rangeKey: String
    public let title: String
    public let babyDescription: String
    public let metadata: String
    public let type: String
    public let created: String
    public let modified: String
    public let status: String

    enum CodingKeys: String, CodingKey {
        case partitionKey = "partition_key"
        case rangeKey = "range_key"
        case title
        case babyDescription = "description"
        case metadata
        case type
        case created
        case modified
        case status
    }
}
