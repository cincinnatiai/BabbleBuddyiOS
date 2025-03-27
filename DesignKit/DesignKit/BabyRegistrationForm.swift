import SwiftUI

struct BabyRegistrationForm: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var gender = "Male"
    @State private var weight = ""
    @State private var weightUnit = "Kilograms"
    @State private var height = ""
    @State private var heightUnit = "Centimeters"
    @State private var bloodType = ""
    @State private var allergies = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    let genders = ["Male", "Female", "Other"]
    let weightUnits = ["Kilograms", "Pounds"]
    let heightUnits = ["Centimeters", "Inches"]

    var body: some View {
        Form {
            Section(header: Text("Baby's First Name:")) {
                TextField("First Name", text: $firstName)
            }
            Section(header: Text("Baby's Last Name:")) {
                TextField("Last Name", text: $lastName)
            }
            Section(header: Text("Baby's Date of Birth:")) {
                DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }
            Section(header: Text("Baby's Gender:")) {
                Picker("Gender", selection: $gender) {
                    ForEach(genders, id: \ .self) {
                        Text($0)
                    }
                }.pickerStyle(MenuPickerStyle())
            }
            Section(header: Text("Baby's Birth Weight")) {
                HStack {
                    TextField("Weight", text: $weight)
                        .keyboardType(.decimalPad)
                    Picker("", selection: $weightUnit) {
                        ForEach(weightUnits, id: \ .self) {
                            Text($0)
                        }
                    }.pickerStyle(MenuPickerStyle())
                }
            }
            Section(header: Text("Baby's Birth Height")) {
                HStack {
                    TextField("Height", text: $height)
                        .keyboardType(.decimalPad)
                    Picker("", selection: $heightUnit) {
                        ForEach(heightUnits, id: \ .self) {
                            Text($0)
                        }
                    }.pickerStyle(MenuPickerStyle())
                }
            }
            Section(header: Text("Baby's Blood Type:")) {
                TextField("Blood Type", text: $bloodType)
            }
            Section(header: Text("Allergies")) {
                TextField("Enter Allergies", text: $allergies)
                Button("Add an Allergy") {
                }
            }
            Section {
                Button("Submit") {
                    if validateForm() {
                    } else {
                        showAlert = true
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Missing Information"),
                          message: Text(alertMessage),
                          dismissButton: .default(Text("OK")))
                }
            }
        }
    }

    private func validateForm() -> Bool {
        let nameRegex = "^[A-Za-z]+$"
        let heightWeightRegex = "^[0-9.'\\\"]+$"

        if firstName.trimmingCharacters(in: .whitespaces).isEmpty || !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: firstName) {
            alertMessage = "Please enter a valid first name using only letters."
            return false
        }
        if lastName.trimmingCharacters(in: .whitespaces).isEmpty || !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: lastName) {
            alertMessage = "Please enter a valid last name using only letters."
            return false
        }
        if weight.trimmingCharacters(in: .whitespaces).isEmpty || !NSPredicate(format: "SELF MATCHES %@", heightWeightRegex).evaluate(with: weight) {
            alertMessage = "Please enter a valid weight using numbers and allowed symbols."
            return false
        }
        if height.trimmingCharacters(in: .whitespaces).isEmpty || !NSPredicate(format: "SELF MATCHES %@", heightWeightRegex).evaluate(with: height) {
            alertMessage = "Please enter a valid height using numbers and allowed symbols."
            return false
        }
        if bloodType.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter the baby's blood type."
            return false
        }
        return true
    }
}

#Preview {
    BabyRegistrationForm()
}
