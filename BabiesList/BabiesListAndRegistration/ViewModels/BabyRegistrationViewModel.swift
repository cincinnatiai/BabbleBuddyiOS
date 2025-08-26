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
    private let babyService: BBABabiesServiceProtocol
    private let userEmail: String
    private var existingBaby: CreateBabyResponseProtocol?

    // MARK: Initializer
    public init(
        userEmail: String,
        babyService: BBABabiesServiceProtocol,
        existingBaby: CreateBabyResponseProtocol? = nil
    ) {
        self.userEmail = userEmail
        self.babyService = babyService
        self.existingBaby = existingBaby
        
        if let existingBaby = existingBaby {
            loadExistingBaby(existingBaby)
        }
    }

    var onSubmit: ((BabyRegistrationData) -> Void)?

    func onSubmitTapped() {
        if validateForm() {
            submit()
        }
    }

    func loadExistingBaby(_ existingBaby: CreateBabyResponseProtocol) {
        if let jsonData = existingBaby.metadata.data(using: .utf8) {
            if let decodedData = try? JSONDecoder().decode(BabyInformationModel.self, from: jsonData) {
                let formatter = ISO8601DateFormatter()
                if let date = formatter.date(from: decodedData.dateOfBirth) {
                    self.dateOfBirth = date
                }
                self.firstName = decodedData.firstName
                self.lastName = decodedData.lastName
                self.selectedGender = decodedData.gender
                self.bloodType = decodedData.bloodType
                self.allergies = decodedData.allergies ?? []
                self.birthWeight = String(decodedData.birthWeight.quantity)
                self.selectedWeightUnit = decodedData.birthWeight.unit
                self.birthHeight = String(decodedData.birthHeight.quantity)
                self.selectedHeightUnit = decodedData.birthHeight.unit
            }
        }
    }
    
    func submit() {
        let formatter = ISO8601DateFormatter()
        let dobString = formatter.string(from: dateOfBirth)
        Task {
            do {
                let metadataJSON = try createMetaData(dobString: dobString)
                if existingBaby != nil {
                    try await editBaby(metaData: metadataJSON, dobString: dobString)
                } else {
                    try await createBaby(metaData: metadataJSON, dobString: dobString)
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func createMetaData(dobString: String) throws -> String {
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

        let jsonData = try JSONEncoder().encode(metadataModel)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw NSError(
                domain: "EncodingError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Error encoding metadata"]
            )
        }
        return jsonString
    }
    
    private func createBaby(metaData: String, dobString: String) async throws {
        let fullName = "\(firstName) \(lastName)"
        let description = "\(dobString)/\(selectedGender)"
        let email = userEmail
        let clientId = "CincinnatiBabyService"

        let request = CreateBabyRequestModel(
            accountType: "DEFAULT",
            clientId: clientId,
            description: description,
            email: email,
            metadata: metaData,
            title: fullName,
            userId: email
        )

        let success = try await babyService.createBaby(request: request)
        await MainActor.run {
            if !success.created.isEmpty {
                self.errorMessage = nil
                didCreateSuccessfully = true
            }
        }
    }

    private func editBaby(metaData: String, dobString: String) async throws {
        let fullName = "\(firstName) \(lastName)"
        let description = "\(dobString)/\(selectedGender)"
        let clientId = "CincinnatiBabyService"
        let created = existingBaby?.created ?? ""
        let modified = existingBaby?.modified ?? ""
        let rangeKey = existingBaby?.rangeKey ?? ""
        let patitionKey = existingBaby?.partitionKey ?? ""
        let status = existingBaby?.status ?? ""
        let type = existingBaby?.type ?? ""

        let editRequest = EditBabyRequestModel(
            clientId: clientId,
            created: created,
            description: description,
            metadata: metaData,
            modified: modified,
            partitionKey: patitionKey,
            rangeKey: rangeKey,
            status: status,
            title: fullName,
            type: type
        )

        let success = try await babyService.editBaby(request: editRequest)
        await MainActor.run {
            if success {
                didCreateSuccessfully = true
                errorMessage = nil
            } else {
                errorMessage = "Failed to update user"
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
