//
//  BabyRegistrationViewModel.swift
//  DesignKit
//
//  Created by CincinnatiAI Dallas on 3/31/25.
//

import Foundation
import Combine

final class BabyRegistrationViewModel: ObservableObject {
    @Published var baby = BabyModel(
        firstName: "",
        lastName: "",
        dateOfBirth: Date(),
        gender: .male,
        weight: 0,
        weightUnit: .kilograms,
        height: 0,
        heightUnit: .centimeters,
        bloodType: "",
        allergies: [""]
    )

    @Published var showAlert = false
    @Published var alertMessage = ""

    func validateForm() -> Bool {
        func isValidName(_ name: String) -> Bool {
            let nameRegex = "^[A-Za-z]+$"
            return !name.trimmingCharacters(in: .whitespaces).isEmpty &&
                NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
        }

        guard isValidName(baby.firstName) else {
            alertMessage = "Please enter a valid first name using only letters."
            return false
        }

        guard isValidName(baby.lastName) else {
            alertMessage = "Please enter a valid last name using only letters."
            return false
        }

        guard baby.weight > 0 else {
            alertMessage = "Please enter a valid weight."
            return false
        }

        guard baby.height > 0 else {
            alertMessage = "Please enter a valid height."
            return false
        }

        guard !baby.bloodType.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter the baby's blood type."
            return false
        }

        if baby.allergies.contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty }) {
            alertMessage = "Please enter valid allergy information or remove empty fields."
            return false
        }

        return true
    }

    private var savePath: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("baby_data.json")
    }

    func saveBabyLocally() {
        do {
            let data = try JSONEncoder().encode(self.baby)
            try data.write(to: savePath, options: .atomic)
            print("Baby data saved to: \(savePath)")
        } catch {
            print("Failed to save baby data: \(error.localizedDescription)")
        }
    }

    func loadSavedBaby() {
        do {
            let data = try Data(contentsOf: savePath)
            let loaded = try JSONDecoder().decode(BabyModel.self, from: data)
            self.baby = loaded
            print("Loaded baby data from local storage.")
        } catch {
            print("No saved data or failed to load: \(error.localizedDescription)")
        }
    }
}
