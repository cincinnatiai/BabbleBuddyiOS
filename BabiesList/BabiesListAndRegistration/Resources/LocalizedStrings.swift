//
//  LocalizedStrings.swift
//  BabiesList
//
//  Created by Trainee on 4/21/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .babiesListModule, comment: "")
    }
}

enum BabiesListLocalizedStringKeys {
    static var BabyListViewScreenTitle: String { "BabyListView_Screen_Title".localized }
    static var FatalErrorMessage: String { "Fatal_Error_Message".localized }
    static var BabyTableViewCellDescriptionLabel: String { "BabyTableViewCell_Description_Label".localized }
    static var BabiesListViewAlertMessageTitle: String { "BabiesListView_AlertMessage_Title".localized }
    static var BabiesListViewAlertActionLabel: String { "BabiesListView_AlertAction_Label".localized }
    static var BabyRegistrationViewFirstNameTitle: String { "BabyRegistrationView_FirstName_Title".localized }
    static var BabyRegistrationViewFirstNamePlaceHolder: String { "BabyRegistrationView_FirstName_PlaceHolder".localized }
    static var BabyRegistrationViewLastNameTitle: String { "BabyRegistrationView_LastName_Title".localized }
    static var BabyRegistrationViewLastNamePlaceHolder: String { "BabyRegistrationView_LastName_PlaceHolder".localized }
    static var BabyRegistrationViewDateOfBirthTitle: String { "BabyRegistrationView_DateOfBirth_Title".localized }
    static var BabyRegistrationViewGenderTitle: String { "BabyRegistrationView_Gender_Title".localized }
    static var BabyRegistrationViewPickerMaleText: String { "BabyRegistrationView_GenderPicker_Male_Text".localized }
    static var BabyRegistrationViewPickerFemaleText: String { "BabyRegistrationView_GenderPicker_Female_Text".localized }
    static var BabyRegistrationViewBirthWeightTitle: String { "BabyRegistrationView_BirthWeight_Title".localized }
    static var BabyRegistrationViewBirthWeightPlaceHolder: String { "BabyRegistrationView_BirthWeight_PlaceHolder".localized }
    static var BabyRegistrationViewBirthWeightKilogramsText: String { "BabyRegistrationView_BirthWeightPicker_Kilograms_Text".localized }
    static var BabyRegistrationViewBirthWeightPickerPoundsText: String { "BabyRegistrationView_BirthWeightPicker_Pounds_Text".localized }
    static var BabyRegistrationViewBirthHeightTitle: String { "BabyRegistrationView_BirthHeight_Title".localized }
    static var BabyRegistrationViewBirthHeightPlaceHolder: String { "BabyRegistrationView_BirthHeight_PlaceHolder".localized }
    static var BabyRegistrationViewBirthHeightPickerCentimetersText: String { "BabyRegistrationView_BirthHeightPicker_Centimeters_Text".localized }
    static var BabyRegistrationViewBirthHeightPickerInchesText: String { "BabyRegistrationView_BirthHeightPicker_Inches_Text".localized }
    static var BabyRegistrationViewBloodTypeTitle: String { "BabyRegistrationView_BloodType_Title".localized }
    static var BabyRegistrationViewBloodTypePlaceHolder: String { "BabyRegistrationView_BloodType_PlaceHolder".localized }
    static var BabyRegistrationViewAllergiesTitle: String { "BabyRegistrationView_Allergies_Title".localized }
    static var BabyRegistrationViewAllergiesPlaceHolder: String { "BabyRegistrationView_Allergies_PlaceHolder".localized }
    static var BabyRegistrationViewSubmitButtonText: String { "BabyRegistrationView_Submit_Button_Text".localized }
    static var CustomDatePickerButtonTitle: String { "CustomDatePicker_Button_Title".localized }
    static var BabyRegistrationScreenTitle: String { "BabyRegistrationView_Screen_Title".localized }
    static var BabyRegistrationViewBabyInfoSectionTitle: String { "BabyRegistrationView_Baby_Info_Section_Title".localized }
    static var BabyRegistrationViewBabyMeasurementsSectionTitle: String { "BabyRegistrationView_Baby_Measurements_Section_Title".localized }
    static var BabyRegistrationViewBabyMedicalInfoSectionTitle: String { "BabyRegistrationView_Medical_Info_Section_Title".localized }
    static var ValidationErrorsEmptyFirstNameText: String { "ValidationErrors_EmptyFirstName_Text".localized }
    static var ValidationErrorsEmptyLastNameText: String { "ValidationErrors_EmptyLastName_Text".localized }
    static var ValidationErrorsEmptyGenderText: String { "ValidationErrors_EmptyGender_Text".localized }
    static var ValidationErrorsEmptyBirthWeightText: String { "ValidationErrors_EmptyBirthWeight_Text".localized }
    static var ValidationErrorsEmptyWeightUnitText: String { "ValidationErrors_EmptyWeightUnit_Text".localized }
    static var ValidationErrorsInvalidWeightValueText: String { "ValidationErrors_InvalidWeightValue_Text".localized }
    static var ValidationErrorsEmptyBirthHeightText: String { "ValidationErrors_EmptyBirthHeight_Text".localized }
    static var ValidationErrorsEmptyHeightUnitText: String { "ValidationErrors_EmptyHeightUnit_Text".localized }
    static var ValidationErrorsInvalidHeightValueText: String { "ValidationErrors_InvalidHeightValue_Text".localized }
    static var ValidationErrorsEmptyBloodTypeText: String { "ValidationErrors_EmptyBloodType_Text".localized }

}
