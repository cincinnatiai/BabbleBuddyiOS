//
//  AccountResponseModel.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation

public struct AccountResponseModel: Codable {
  let accountProfile: AccountProfile?
  let account: AccountModel?
    
    enum CodingKeys: String, CodingKey {
        case accountProfile = "account_profile"
        case account
    }
}
