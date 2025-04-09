//
//  AccountProfile.swift
//  babiesList
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
}
