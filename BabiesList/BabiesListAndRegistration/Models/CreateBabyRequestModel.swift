//
//  CreateBabyRequestModel.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 6/15/25.
//
public struct CreateBabyRequestModel: Codable, CreateBabyRequestProtocol {
    public let accountType: String
    public let clientId: String
    public let description: String
    public let email: String
    public let metadata: String
    public let title: String
    public let userId: String

    enum CodingKeys: String, CodingKey {
        case accountType = "account_type"
        case clientId = "client_id"
        case description
        case email
        case metadata
        case title
        case userId = "user_id"
    }
}
