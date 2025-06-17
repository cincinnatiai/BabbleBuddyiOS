//
//  AccountProfile.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation
import BabiesListAndRegistration

public struct AccountProfileModel: Codable, AccountProfileProtocol {
    public let partitionKey: String?
    public let rangeKey: String?
    public let firstName: String?
    public let middleName: String?
    public let lastName: String?
    public let encryptedEmail: String?
    public let permissions: Int?
    public let created: String?
    public let modified: String?
    public let status: String?
    
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
