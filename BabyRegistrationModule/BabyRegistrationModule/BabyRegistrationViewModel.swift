//
//  BabyRegistrationViewModel.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/28/25.
//

import Foundation
import SwiftUI
import Combine

class BabyRegistrationViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var bloodType: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var selectedGender: String = ""
    @Published var birthWeight: String = ""
    @Published var selectedWeightUnit: String = ""
    @Published var birthHeight: String = ""
    @Published var selectedHeightUnit: String = ""
    @Published var allergies: [String] = [""]
    @Published var errorMessage: String? = nil
    
    var onSubmit: ((BabyRegistrationData) -> Void)?
    
    func submit() {
        let data = BabyRegistrationData(
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            selectedGender: selectedGender,
            birthWeight: birthWeight,
            selectedWeightUnit: selectedWeightUnit,
            birthHeight: birthHeight,
            selectedHeightUnit: selectedHeightUnit,
            bloodType: bloodType,
            allergies: allergies
        )
        onSubmit?(data)
        print("Form submitted with: \n Name: \(firstName) \n Last Name: \(lastName) \n Blood Type: \(bloodType) \n Date of Birth: \(dateOfBirth) \n Gender: \(selectedGender) \n Weight: \(birthWeight)\(selectedWeightUnit) \n Height: \(birthHeight) \(selectedHeightUnit) \n Allergies: \(allergies)")
    }
    
    func validateForm() -> Bool {
        if let validationError = validateFields() {
            errorMessage = validationError.localizedDesription
            return false
        }
        errorMessage = nil
        return true
    }

    
    func validateFields() -> BabyRegistrationResources.ValidationErrors? {
        if let error = validateFirstName() { return error }
        if let error = validateLastName() { return error }
        if let error = validateGender() { return error }
        if let error = validateBirthWeight() { return error }
        if let error = validateBirthHeight() { return error }
        if let error = validateBloodType() { return error }
        return nil
    }
    
    private func validateFirstName() -> BabyRegistrationResources.ValidationErrors? {
        return firstName.isEmpty ? .emptyFirstName : nil
    }
    
    private func validateLastName() -> BabyRegistrationResources.ValidationErrors? {
        return lastName.isEmpty ? .emptyLastName : nil
    }
    
    private func validateGender() -> BabyRegistrationResources.ValidationErrors? {
        return selectedGender.isEmpty ? .emptyGender : nil
    }
    
    private func validateBirthWeight() -> BabyRegistrationResources.ValidationErrors? {
        guard !birthWeight.isEmpty else { return .emptyBirthWeight }
        guard Double(birthWeight) != nil else { return .invalidWeightValue }
        guard !selectedWeightUnit.isEmpty else { return .emptyWeigthUnit }
        return nil
    }
    
    private func validateBirthHeight() -> BabyRegistrationResources.ValidationErrors? {
        guard !birthHeight.isEmpty else { return .emptyBirthHeight }
        guard Double(birthHeight) != nil else { return .invalidHeightValue }
        guard !selectedHeightUnit.isEmpty else { return .emptyHeightUnit }
        return nil
    }
    
    private func validateBloodType() -> BabyRegistrationResources.ValidationErrors? {
        return bloodType.isEmpty ? .emptyBloodType  : nil
    }
}
