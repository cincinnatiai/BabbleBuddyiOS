//
//  CreateBabyResponseModel.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 6/15/25.
//

public struct CreateBabyResponseModel: Codable {
    let partitionKey: String
    let rangeKey: String
    let title: String
    let description: String
    let metadata: String
    let type: String
    let created: String
    let modified: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case partitionKey = "partition_key"
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
