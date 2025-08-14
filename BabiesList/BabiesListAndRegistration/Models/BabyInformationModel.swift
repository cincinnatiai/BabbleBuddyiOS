//
//  BabyInformationModel.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 6/15/25.
//

public struct BabyInformationModel: Codable {
    let firstName: String
    let lastName: String
    let dateOfBirth: String
    let gender: String
    let birthWeight: QuantityUnitModel
    let birthHeight: QuantityUnitModel
    let currentWeight: QuantityUnitModel?
    let currentHeight: QuantityUnitModel?
    let bloodType: String
    let allergies: [String]?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case dateOfBirth = "date_of_birth"
        case gender
        case birthWeight = "birth_weight"
        case birthHeight = "birth_height"
        case currentWeight = "current_weight"
        case currentHeight = "current_height"
        case bloodType = "blood_type"
        case allergies
    }
}
