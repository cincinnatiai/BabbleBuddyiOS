//
//  Baby.swift
//  DesignKit
//
//  Created by CincinnatiAI Dallas on 3/31/25.
//

enum Gender: String, CaseIterable, Identifiable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
    var id: String { rawValue }
}

enum WeightUnit: String, CaseIterable, Identifiable {
    case kilograms = "Kilograms"
    case pounds = "Pounds"

    var id: String { rawValue }
}

enum HeightUnit: String, CaseIterable, Identifiable {
    case centimeters = "Centimeters"
    case inches = "Inches"

    var id: String { rawValue }
}

struct Baby {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var gender: Gender
    var weight: String
    var weightUnit: WeightUnit
    var height: String
    var heightUnit: HeightUnit
    var bloodType: String
    var allergies: String
}
