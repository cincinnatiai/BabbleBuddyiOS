import SwiftUI

struct BabyRegistrationForm: View {
    @StateObject private var viewModel = BabyRegistrationViewModel()

    var body: some View {
        Form {
            Section(header: Text("Baby's First Name:")) {
                TextField("First Name", text: $viewModel.baby.firstName)
            }
            Section(header: Text("Baby's Last Name:")) {
                TextField("Last Name", text: $viewModel.baby.lastName)
            }
            Section(header: Text("Baby's Date of Birth:")) {
                DatePicker("", selection: $viewModel.baby.dateOfBirth, displayedComponents: .date)
            }
            Section(header: Text("Baby's Gender:")) {
                Picker("Gender", selection: $viewModel.baby.gender) {
                    ForEach(Gender.allCases) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            Section(header: Text("Baby's Birth Weight")) {
                HStack {
                    TextField("Weight", text: $viewModel.baby.weight)
                        .keyboardType(.decimalPad)
                    Picker("", selection: $viewModel.baby.weightUnit) {
                        ForEach(WeightUnit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }.pickerStyle(MenuPickerStyle())
                }
            }
            Section(header: Text("Baby's Birth Height")) {
                HStack {
                    TextField("Height", text: $viewModel.baby.height)
                        .keyboardType(.decimalPad)
                    Picker("", selection: $viewModel.baby.heightUnit) {
                        ForEach(HeightUnit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }.pickerStyle(MenuPickerStyle())
                }
            }
            Section(header: Text("Baby's Blood Type:")) {
                TextField("Blood Type", text: $viewModel.baby.bloodType)
            }
            Section(header: Text("Allergies")) {
                TextField("Enter Allergies", text: $viewModel.baby.allergies)
                Button("Add an Allergy") {
                    // Logic for adding allergies (future improvement)
                }
            }
            Section {
                Button("Submit") {
                    if !viewModel.validateForm() {
                        viewModel.showAlert = true
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Missing Information"),
                          message: Text(viewModel.alertMessage),
                          dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

#Preview {
    BabyRegistrationForm()
}
