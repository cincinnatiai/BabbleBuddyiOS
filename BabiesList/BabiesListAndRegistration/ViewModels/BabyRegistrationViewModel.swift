//
//  BabyRegistrationViewModel.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/28/25.
//

import Foundation
import SwiftUI
import Combine

public final class BabyRegistrationViewModel: ObservableObject {

    // MARK: Published properties
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
    @Published private(set) var didCreateSuccessfully = false

    // MARK: Private properties
    private let createAPI: (
        CreateBabyRequestProtocol
    ) async throws -> CreateBabyResponseProtocol
    private let userEmail: String

    // MARK: Initializer
    public init(userEmail: String,createAPI: @escaping (CreateBabyRequestProtocol) async throws -> CreateBabyResponseProtocol) {
        self.userEmail = userEmail
        self.createAPI = createAPI
    }

    var onSubmit: ((BabyRegistrationData) -> Void)?

    func onSubmitTapped() {
        if validateForm() {
            submit()
        }
    }

    func submit() {
        Task {
            let formatter = ISO8601DateFormatter()
            let dobString = formatter.string(from: dateOfBirth)

            let weight = Int(Double(birthWeight) ?? 0)
            let height = Int(Double(birthHeight) ?? 0)

            let metadataModel = BabyInformationModel(
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dobString,
                gender: selectedGender,
                birthWeight: QuantityUnitModel(quantity: weight, unit: selectedWeightUnit),
                birthHeight: QuantityUnitModel(quantity: height, unit: selectedHeightUnit),
                currentWeight: QuantityUnitModel(quantity: weight, unit: selectedWeightUnit),
                currentHeight: QuantityUnitModel(quantity: height, unit: selectedHeightUnit),
                bloodType: bloodType,
                allergies: allergies
            )

            guard let jsonData = try? JSONEncoder().encode(metadataModel),
                  let jsonString = String(data: jsonData, encoding: .utf8) else {
                await MainActor.run {
                    self.errorMessage = "Error encoding metadata"
                }
                return
            }

            let fullName = "\(firstName) \(lastName)"
            let description = "\(dobString)/\(selectedGender)"
            let email = userEmail
            let clientId = "CincinnatiBabyService"

            let request = CreateBabyRequestModel(
                accountType: "DEFAULT",
                clientId: clientId,
                description: description,
                email: email,
                metadata: jsonString,
                title: fullName,
                userId: email
            )

            do {
                let success = try await createAPI(request)
                await MainActor.run {
                    if !success.created.isEmpty {
                        self.errorMessage = nil
                        didCreateSuccessfully = true
                    } else {
                        self.errorMessage = "Something went wrong"
                    }
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
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
        guard !birthWeight.isEmpty else { return nil }
        guard Double(birthWeight) != nil else { return .invalidWeightValue }
        guard !selectedWeightUnit.isEmpty else { return .emptyWeigthUnit }
        return nil
    }

    private func validateBirthHeight() -> BabyRegistrationResources.ValidationErrors? {
        guard !birthHeight.isEmpty else { return nil }
        guard Double(birthHeight) != nil else { return .invalidHeightValue }
        guard !selectedHeightUnit.isEmpty else { return .emptyHeightUnit }
        return nil
    }
}
