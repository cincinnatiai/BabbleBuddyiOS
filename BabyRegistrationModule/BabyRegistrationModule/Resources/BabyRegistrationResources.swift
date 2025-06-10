//
//  LocalizedStrings.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/24/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .babyRegistrationModule, comment: "")
    }
}

enum BabyRegistrationModuleLocalizedStringKeys {
    static let BabyRegistrationViewFirstNameTitle = "BabyRegistrationView_FirstName_Title".localized
    static let BabyRegistrationViewFirstNamePlaceHolder = "BabyRegistrationView_FirstName_PlaceHolder".localized
    static let BabyRegistrationViewLastNameTitle = "BabyRegistrationView_LastName_Title".localized
    static let BabyRegistrationViewLastNamePlaceHolder = "BabyRegistrationView_LastName_PlaceHolder".localized
    static let BabyRegistrationViewDateOfBirthTitle = "BabyRegistrationView_DateOfBirth_Title".localized
    static let BabyRegistrationViewGenderTitle = "BabyRegistrationView_Gender_Title".localized
    static let BabyRegistrationViewGenderPickerMaleText = "BabyRegistrationView_GenderPicker_Male_Text".localized
    static let BabyRegistrationViewGenderPickerFemaleText = "BabyRegistrationView_GenderPicker_Female_Text".localized
    static let BabyRegistrationViewBirthWeightTitle = "BabyRegistrationView_BirthWeight_Title".localized
    static let BabyRegistrationViewBirthWeightPlaceHolder = "BabyRegistrationView_BirthWeight_PlaceHolder".localized
    static let BabyRegistrationViewBirthWeightPickerKilogramsText = "BabyRegistrationView_BirthWeightPicker_Kilograms_Text".localized
    static let BabyRegistrationViewBirthWeightPickerPoundsText = "BabyRegistrationView_BirthWeightPicker_Pounds_Text".localized
    static let BabyRegistrationViewBirthHeightTitle = "BabyRegistrationView_BirthHeight_Title".localized
    static let BabyRegistrationViewBirthHeightPlaceHolder = "BabyRegistrationView_BirthHeight_PlaceHolder".localized
    static let BabyRegistrationViewBirthHeightPickerCentimetersText = "BabyRegistrationView_BirthHeightPicker_Centimeters_Text".localized
    static let BabyRegistrationViewBirthHeightPickerInchesText = "BabyRegistrationView_BirthHeightPicker_Inches_Text".localized
    static let BabyRegistrationViewBloodTypeTitle = "BabyRegistrationView_BloodType_Title".localized
    static let BabyRegistrationViewBloodTypePlaceHolder = "BabyRegistrationView_BloodType_PlaceHolder".localized
    static let BabyRegistrationViewAllergiesTitle = "BabyRegistrationView_Allergies_Title".localized
    static let BabyRegistrationViewAllergiesPlaceHolder = "BabyRegistrationView_Allergies_PlaceHolder".localized
    static let BabyRegistrationViewSubmitButtonText = "BabyRegistrationView_Submit_Button_Text".localized
    
    static let ValidationErrorsEmptyFirstNameText = "ValidationErrors_EmptyFirstName_Text".localized
    static let ValidationErrorsEmptyLastNameText = "ValidationErrors_EmptyLastName_Text".localized
    static let ValidationErrorsEmptyGenderText = "ValidationErrors_EmptyGender_Text".localized
    static let ValidationErrorsEmptyBirthWeightText = "ValidationErrors_EmptyBirthWeight_Text".localized
    static let ValidationErrorsEmptyWeightUnitText = "ValidationErrors_EmptyWeightUnit_Text".localized
    static let ValidationErrorsInvalidWeightValueText = "ValidationErrors_InvalidWeightValue_Text".localized
    static let ValidationErrorsEmptyBirthHeightText = "ValidationErrors_EmptyBirthHeight_Text".localized
    static let ValidationErrorsEmptyHeightUnitText = "ValidationErrors_EmptyHeightUnit_Text".localized
    static let ValidationErrorsInvalidHeightValueText = "ValidationErrors_InvalidHeightValue_Text".localized
    static let ValidationErrorsEmptyBloodTypeText = "ValidationErrors_EmptyBloodType_Text".localized
    
    
}

enum BabyRegistrationResources {
    
    enum UnitsKeys: String {
        case kg
        case lbs
        case cm
        case inch = "in"
    }
    
    enum GenderKeys: String {
        case Male
        case Female
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
            case .emptyFirstName : return BabyRegistrationModuleLocalizedStringKeys.ValidationErrorsEmptyFirstNameText
            case .emptyLastName : return BabyRegistrationModuleLocalizedStringKeys.ValidationErrorsEmptyLastNameText
            case .emptyGender : return BabyRegistrationModuleLocalizedStringKeys.ValidationErrorsEmptyGenderText
            case .emptyWeigthUnit : return BabyRegistrationModuleLocalizedStringKeys.ValidationErrorsEmptyWeightUnitText
            case .invalidWeightValue : return BabyRegistrationModuleLocalizedStringKeys.ValidationErrorsInvalidWeightValueText
            case .emptyHeightUnit : return BabyRegistrationModuleLocalizedStringKeys.ValidationErrorsEmptyHeightUnitText
            case .invalidHeightValue : return BabyRegistrationModuleLocalizedStringKeys.ValidationErrorsInvalidHeightValueText
            }
        }
    }
}


