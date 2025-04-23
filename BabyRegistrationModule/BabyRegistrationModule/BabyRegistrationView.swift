//
//  BabyRegistrationModule.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/23/25.
//

import Foundation
import SwiftUI

struct BabyRegistrationView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var bloodType: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var selectedGender: String = ""
    @State private var birthWeight: String = ""
    @State private var selectedWeightUnit: String = ""
    @State private var birthHeight: String = ""
    @State private var selectedHeightUnit: String = ""
    @State private var allergies: [String] = [""]
    private let localizedStrings = BabyRegistrationModuleLocalizedStringKeys.self
    
    var body: some View {
        Form {
            Section {
                LabelAndTextField(title: localizedStrings.BabyRegistrationViewFirstNameTitle, inputPlaceHolder: localizedStrings.BabyRegistrationViewFirstNamePlaceHolder, inputBinder: $firstName)
            }
            
            Section {
                LabelAndTextField(title: localizedStrings.BabyRegistrationViewLastNameTitle, inputPlaceHolder: localizedStrings.BabyRegistrationViewLastNamePlaceHolder, inputBinder: $lastName)
            }
            
            Section {
                VStack(alignment: .leading) {
                    Text(localizedStrings.BabyRegistrationViewDateOfBirthTitle).bold()
                    CustomDatePicker(selectedDate: $dateOfBirth)
                }
            }
            
            Section {
                VStack(alignment: .leading) {
                    Text(localizedStrings.BabyRegistrationViewGenderTitle).bold()
                    Picker("", selection: $selectedGender) {
                        Text(localizedStrings.BabyRegistrationViewGenderPickerMaleText).tag(GenderKeys.Male)
                        Text(localizedStrings.BabyRegistrationViewGenderPickerFemaleText).tag(GenderKeys.Female)
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Section {
                VStack(alignment: .leading) {
                    LabelAndTextField(title: localizedStrings.BabyRegistrationViewBirthWeightTitle, inputPlaceHolder: localizedStrings.BabyRegistrationViewBirthWeightPlaceHolder, inputBinder: $birthWeight)
                    Picker("", selection: $selectedWeightUnit) {
                        Text(localizedStrings.BabyRegistrationViewBirthWeightPickerKilogramsText).tag(UnitsKeys.kg)
                        Text(localizedStrings.BabyRegistrationViewBirthWeightPickerPoundsText).tag(UnitsKeys.lbs)
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Section {
                VStack(alignment: .leading) {
                    LabelAndTextField(title: localizedStrings.BabyRegistrationViewBirthHeightTitle, inputPlaceHolder: localizedStrings.BabyRegistrationViewBirthHeightPlaceHolder, inputBinder: $birthHeight)
                    Picker("", selection: $selectedHeightUnit) {
                        Text(localizedStrings.BabyRegistrationViewBirthHeightPickerCentimetersText).tag(UnitsKeys.cm)
                        Text(localizedStrings.BabyRegistrationViewBirthHeightPickerInchesText).tag(UnitsKeys.inch)
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Section {
                LabelAndTextField(title: localizedStrings.BabyRegistrationViewBloodTypeTitle, inputPlaceHolder: localizedStrings.BabyRegistrationViewBloodTypePlaceHolder, inputBinder: $bloodType)
            }
            

            
            Section {
                Text(localizedStrings.BabyRegistrationViewAllergiesTitle).bold()
                ForEach(allergies.indices, id: \.self) { index in
                    HStack {
                        TextField(localizedStrings.BabyRegistrationViewAllergiesPlaceHolder, text: $allergies[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        let isLastItem = index == allergies.indices.last
                        if isLastItem {
                            Button(action: {
                                allergies.append("")
                            }) {
                                Image(systemName: BabyRegistrationIcons.plusIcon)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            
            Section {
                Button(action: submitForm) {
                    Text(localizedStrings.BabyRegistrationViewSubmitButtonText)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(CGConstants.buttonCornerRadius)
                }
            }
        }
    }
    
    func submitForm() {
        print("Form submitted with: \n Name: \(firstName) \n Last Name: \(lastName) \n Blood Type: \(bloodType) \n Date of Birth: \(dateOfBirth) \n Gender: \(selectedGender) \n Weight: \(birthWeight) \(selectedWeightUnit) \n Height: \(birthHeight) \(selectedHeightUnit) \n Allergies: \(allergies)")
    }
}

#Preview {
    BabyRegistrationView()
}

