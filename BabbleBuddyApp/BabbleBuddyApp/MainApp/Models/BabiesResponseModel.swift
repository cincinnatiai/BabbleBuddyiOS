//
//  AccountResponseModel.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation
import BabiesListAndRegistration

public struct BabiesResponseModel: Codable {
    private let rawAccountProfile: AccountProfileModel?
    private let rawAccount: AccountModel?

    enum CodingKeys: String, CodingKey {
        case rawAccountProfile = "account_profile"
        case rawAccount = "account"
    }
}

extension BabiesResponseModel: BabiesResponseProtocol {
    public var account: AccountProtocol? {
        return rawAccount
    }

    public var accountProfile: AccountProfileProtocol? {
        return rawAccountProfile
    }
}
