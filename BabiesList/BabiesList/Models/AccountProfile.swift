//
//  AccountProfile.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation

public struct AccountProfile: Codable {
    let partitionKey: String?
    let rangeKey: String?
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let encryptedEmail: String?
    let permissions: Int?
    let created: String?
    let modified: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case partitionKey = "partition_key"
        case rangeKey = "range_key"
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case encryptedEmail = "encrypted_email"
        case permissions
        case created
        case modified
        case status
    }
}
