//
//  Constants.swift
//  BabiesList
//
//  Created by Trainee on 4/10/25.
//

import Foundation

public struct ConstraintConstants {
    static let constraintConstantCG16: CGFloat = 16
    static let constraintConstantCG8: CGFloat = 8
    static let constraintConstantCG12: CGFloat = 12
    static let contstraintConstantNegativeCG16: CGFloat = -16
    static let contstraintConstantNegativeCG12: CGFloat = -12
    static let contstraintConstantNegativeCG8: CGFloat = -8
}

public struct SizeConstants {
    static let CGFSize20: CGFloat = 20
    static let CGFSize12: CGFloat = 12
    static let CGFSize4: CGFloat = 4
}

public enum Constants {
    static let tableViewCellIdentifier: String = "BabyTableViewCell"
}

enum BabyRegistrationResources {
    
    enum UnitsKeys: String {
        case kg
        case lbs
        case cm
        case inch = "in"
    }
    
    enum GenderKeys: String {
        case male
        case female
    }
    
    enum Icons {
        static let plusIcon = "plus.circle.fill"
    }
    
    struct CGConstants {
        static let buttonCornerRadius: CGFloat = 10
        static let viewSpacing: CGFloat = 20
    }
    
    enum ValidationErrors {
        case emptyFirstName
        case emptyLastName
        case emptyGender
        case emptyWeigthUnit
        case invalidWeightValue
        case emptyHeightUnit
        case invalidHeightValue
        
        var localizedDesription: String {
            switch self {
            case .emptyFirstName: return BabiesListLocalizedStringKeys.ValidationErrorsEmptyFirstNameText
            case .emptyLastName: return BabiesListLocalizedStringKeys.ValidationErrorsEmptyLastNameText
            case .emptyGender: return BabiesListLocalizedStringKeys.ValidationErrorsEmptyGenderText
            case .emptyWeigthUnit: return BabiesListLocalizedStringKeys.ValidationErrorsEmptyWeightUnitText
            case .invalidWeightValue: return BabiesListLocalizedStringKeys.ValidationErrorsInvalidWeightValueText
            case .emptyHeightUnit: return BabiesListLocalizedStringKeys.ValidationErrorsEmptyHeightUnitText
            case .invalidHeightValue: return BabiesListLocalizedStringKeys.ValidationErrorsInvalidHeightValueText
            }
        }
    }
}
