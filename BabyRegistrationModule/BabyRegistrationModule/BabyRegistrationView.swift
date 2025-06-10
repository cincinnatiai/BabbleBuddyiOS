//
//  BabyRegistrationModule.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/23/25.
//

import Foundation
import SwiftUI

struct BabyRegistrationView: View {
    
    @StateObject var viewModel: BabyRegistrationViewModel
    
    private let localizedStrings = BabyRegistrationModuleLocalizedStringKeys.self
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: BabyRegistrationResources.CGConstants.viewSpacing) {
                LabelAndTextField(title: localizedStrings.BabyRegistrationViewFirstNameTitle, inputPlaceHolder: localizedStrings.BabyRegistrationViewFirstNamePlaceHolder, inputBinder: $viewModel.firstName)
                Divider()
                
                LabelAndTextField(title: localizedStrings.BabyRegistrationViewLastNameTitle, inputPlaceHolder: localizedStrings.BabyRegistrationViewLastNamePlaceHolder, inputBinder: $viewModel.lastName)
                Divider()
                
                Text(localizedStrings.BabyRegistrationViewDateOfBirthTitle).bold()
                CustomDatePicker(selectedDate: $viewModel.dateOfBirth)
                Divider()
                
                Text(localizedStrings.BabyRegistrationViewGenderTitle).bold()
                Picker("", selection: $viewModel.selectedGender) {
                    Text(localizedStrings.BabyRegistrationViewGenderPickerMaleText).tag(BabyRegistrationResources.GenderKeys.Male.rawValue)
                    Text(localizedStrings.BabyRegistrationViewGenderPickerFemaleText).tag(BabyRegistrationResources.GenderKeys.Female.rawValue)
                }
                .pickerStyle(.segmented)
                Divider()
                
                LabelAndTextField(title: localizedStrings.BabyRegistrationViewBirthWeightTitle,
                                  inputPlaceHolder: localizedStrings.BabyRegistrationViewBirthWeightPlaceHolder,
                                  inputBinder: $viewModel.birthWeight, keyboardType: .decimalPad)
                Picker("", selection: $viewModel.selectedWeightUnit) {
                    Text(localizedStrings.BabyRegistrationViewBirthWeightPickerKilogramsText).tag(BabyRegistrationResources.UnitsKeys.kg.rawValue)
                    Text(localizedStrings.BabyRegistrationViewBirthWeightPickerPoundsText).tag(BabyRegistrationResources.UnitsKeys.lbs.rawValue)
                }
                .pickerStyle(.segmented)
                Divider()
                
                LabelAndTextField(title: localizedStrings.BabyRegistrationViewBirthHeightTitle,
                                  inputPlaceHolder: localizedStrings.BabyRegistrationViewBirthHeightPlaceHolder,
                                  inputBinder: $viewModel.birthHeight, keyboardType: .decimalPad)
                
                Picker("", selection: $viewModel.selectedHeightUnit) {
                    Text(localizedStrings.BabyRegistrationViewBirthHeightPickerCentimetersText).tag(BabyRegistrationResources.UnitsKeys.cm.rawValue)
                    Text(localizedStrings.BabyRegistrationViewBirthHeightPickerInchesText).tag(BabyRegistrationResources.UnitsKeys.inch.rawValue)
                }
                .pickerStyle(.segmented)
                Divider()
                
                LabelAndTextField(title: localizedStrings.BabyRegistrationViewBloodTypeTitle, inputPlaceHolder: localizedStrings.BabyRegistrationViewBloodTypePlaceHolder, inputBinder: $viewModel.bloodType)
                Divider()
                
                
                
                Text(localizedStrings.BabyRegistrationViewAllergiesTitle).bold()
                ForEach(viewModel.allergies.indices, id: \.self) { index in
                    HStack {
                        TextField(localizedStrings.BabyRegistrationViewAllergiesPlaceHolder, text: $viewModel.allergies[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        let isLastItem = index == viewModel.allergies.indices.last
                        if isLastItem {
                            Button(action: {
                                viewModel.allergies.append("")
                            }) {
                                Image(systemName: BabyRegistrationResources.Icons.plusIcon)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                Divider()
                
                Button(action: {
                        viewModel.onSubmitTapped()
                }) {
                    Text(localizedStrings.BabyRegistrationViewSubmitButtonText)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(BabyRegistrationResources.CGConstants.buttonCornerRadius)
                }
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).bold()
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
        }
    }
}

#Preview {
    BabyRegistrationView(viewModel: BabyRegistrationViewModel())
}
