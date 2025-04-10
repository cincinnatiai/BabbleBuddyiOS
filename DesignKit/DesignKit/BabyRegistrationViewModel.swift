import Foundation
import Combine

final class BabyRegistrationViewModel: ObservableObject {
    @Published var baby = Baby(
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
        let nameRegex = "^[A-Za-z]+$"

        if baby.firstName.trimmingCharacters(in: .whitespaces).isEmpty
            || !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: baby.firstName) {
            alertMessage = "Please enter a valid first name using only letters."
            return false
        }
        if baby.lastName.trimmingCharacters(in: .whitespaces).isEmpty
            || !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: baby.lastName) {
            alertMessage = "Please enter a valid last name using only letters."
            return false
        }
        if baby.weight <= 0 {
            alertMessage = "Please enter a valid weight."
            return false
        }
        if baby.height <= 0 {
            alertMessage = "Please enter a valid height."
            return false
        }
        if baby.bloodType.trimmingCharacters(in: .whitespaces).isEmpty {
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
            let loaded = try JSONDecoder().decode(Baby.self, from: data)
            self.baby = loaded
            print("Loaded baby data from local storage.")
        } catch {
            print("No saved data or failed to load: \(error.localizedDescription)")
        }
    }
}
