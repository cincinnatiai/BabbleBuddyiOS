//
//  BabyRegistrationModule.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/23/25.
//

import Foundation
import SwiftUI
import DesignKit
import SettingsModule

public struct BabyRegistrationView: View {
    @ObservedObject var viewModel: BabyRegistrationViewModel
    private let bloodTypes = ["A+","A-","B+","B-","AB+","AB-","O+","O-"]
    @ObservedObject var languageManager = LanguageManager.shared
    private var localizedStrings: BabiesListLocalizedStringKeys.Type { BabiesListLocalizedStringKeys.self }

    // TODO: Delete this when implementing details
    let onComplete: () -> Void

    public init(viewModel: BabyRegistrationViewModel, onComplete: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onComplete = onComplete
    }

    public var body: some View {
        BBVStack {
            BBCardSectionViewContainer(
                title: localizedStrings.BabyRegistrationViewBabyInfoSectionTitle,
                icon: Image(systemName: "face.smiling")
            ) {
                BBTextfield(
                    inputPlaceHolder: localizedStrings.BabyRegistrationViewFirstNameTitle,
                    inputBinder: $viewModel.firstName
                )
                BBTextfield(inputPlaceHolder: localizedStrings.BabyRegistrationViewLastNameTitle, inputBinder: $viewModel.lastName)
                BBHStack {
                    BBDatePicker(
                        selectedDate: $viewModel.dateOfBirth,
                        closingButtonLabel: localizedStrings.CustomDatePickerButtonTitle
                    )
                    Picker("", selection: $viewModel.selectedGender) {
                        Text(
                            localizedStrings.BabyRegistrationViewPickerMaleText
                        )
                        .tag(BabyRegistrationResources.GenderKeys.male.rawValue)
                        Text(
                            localizedStrings.BabyRegistrationViewPickerFemaleText
                        )
                        .tag(
                            BabyRegistrationResources.GenderKeys.female.rawValue
                        )
                    }
                    .pickerStyle(.segmented)
                }
            }

            BBCardSectionViewContainer(
                title: localizedStrings.BabyRegistrationViewBabyMeasurementsSectionTitle,
                icon: Image(systemName: "pencil.and.ruler")
            ) {
                BBHStack {
                    BBTextfield(
                        inputPlaceHolder: localizedStrings.BabyRegistrationViewBirthWeightTitle,
                        inputBinder: $viewModel.birthWeight, keyboardType: .decimalPad)
                    Picker("", selection: $viewModel.selectedWeightUnit) {
                        Text(localizedStrings.BabyRegistrationViewBirthWeightKilogramsText).tag(BabyRegistrationResources.UnitsKeys.kg.rawValue)
                        Text(localizedStrings.BabyRegistrationViewBirthWeightPickerPoundsText).tag(BabyRegistrationResources.UnitsKeys.lbs.rawValue)
                    }
                    .pickerStyle(.segmented)
                }
                BBHStack {
                    BBTextfield(
                        inputPlaceHolder: localizedStrings.BabyRegistrationViewBirthHeightTitle,
                        inputBinder: $viewModel.birthHeight, keyboardType: .decimalPad)

                    Picker("", selection: $viewModel.selectedHeightUnit) {
                        Text(localizedStrings.BabyRegistrationViewBirthHeightPickerCentimetersText).tag(BabyRegistrationResources.UnitsKeys.cm.rawValue)
                        Text(localizedStrings.BabyRegistrationViewBirthHeightPickerInchesText).tag(BabyRegistrationResources.UnitsKeys.inch.rawValue)
                    }
                    .pickerStyle(.segmented)
                }
            }

            BBCardSectionViewContainer(
                title: localizedStrings.BabyRegistrationViewBabyMedicalInfoSectionTitle,
                icon: Image(systemName: "drop")
            ) {
                BBWheelPicker(
                    options: bloodTypes,
                    selected: $viewModel.bloodType,
                    title: localizedStrings.BabyRegistrationViewBloodTypeTitle,
                    doneButtonLabel: localizedStrings.CustomDatePickerButtonTitle
                )
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
            }
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
            .onReceive(viewModel.$didCreateSuccessfully) { success in
                if success {
                    onComplete()
                }
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage).bold()
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
