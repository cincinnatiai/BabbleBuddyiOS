import Foundation
import Combine

final class BabyRegistrationViewModel: ObservableObject {
    @Published var baby = Baby(
        firstName: "",
        lastName: "",
        dateOfBirth: Date(),
        gender: .male,
        weight: "",
        weightUnit: .kilograms,
        height: "",
        heightUnit: .centimeters,
        bloodType: "",
        allergies: ""
    )

    @Published var showAlert = false
    @Published var alertMessage = ""

    func validateForm() -> Bool {
        let nameRegex = "^[A-Za-z]+$"
        let heightWeightRegex = "^[0-9.'\\\"]+$"

        if baby.firstName.trimmingCharacters(in: .whitespaces).isEmpty || !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: baby.firstName) {
            alertMessage = "Please enter a valid first name using only letters."
            return false
        }
        if baby.lastName.trimmingCharacters(in: .whitespaces).isEmpty || !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: baby.lastName) {
            alertMessage = "Please enter a valid last name using only letters."
            return false
        }
        if baby.weight.trimmingCharacters(in: .whitespaces).isEmpty || !NSPredicate(format: "SELF MATCHES %@", heightWeightRegex).evaluate(with: baby.weight) {
            alertMessage = "Please enter a valid weight."
            return false
        }
        if baby.height.trimmingCharacters(in: .whitespaces).isEmpty || !NSPredicate(format: "SELF MATCHES %@", heightWeightRegex).evaluate(with: baby.height) {
            alertMessage = "Please enter a valid height."
            return false
        }
        if baby.bloodType.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter the baby's blood type."
            return false
        }
        return true
    }
}
