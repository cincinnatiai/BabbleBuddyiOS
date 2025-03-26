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
                if height == "0" {
                    Text("Please enter a valid height.")
                        .font(.caption)
                        .foregroundColor(.red)
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
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

#Preview {
    BabyRegistrationForm()
}
