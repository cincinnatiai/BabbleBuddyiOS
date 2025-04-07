import SwiftUI

struct BabyRegistrationForm: View {
    @StateObject private var viewModel = BabyRegistrationViewModel()

    var body: some View {
        Form {
            DKTextField("First Name", text: $viewModel.baby.firstName)
            DKTextField("Last Name", text: $viewModel.baby.lastName)
            DKDatePicker("Date of Birth", date: $viewModel.baby.dateOfBirth)
            DKPicker("Gender", options: Gender.allCases, selection: $viewModel.baby.gender)

            HStack {
                DKTextField("Weight", text: $viewModel.baby.weight, keyboard: .decimalPad)
                DKPicker("", options: WeightUnit.allCases, selection: $viewModel.baby.weightUnit)
            }

            HStack {
                DKTextField("Height", text: $viewModel.baby.height, keyboard: .decimalPad)
                DKPicker("", options: HeightUnit.allCases, selection: $viewModel.baby.heightUnit)
            }

            DKTextField("Blood Type", text: $viewModel.baby.bloodType)
            DKTextField("Allergies", text: $viewModel.baby.allergies)

            DKButton("Submit") {
                if !viewModel.validateForm() {
                    viewModel.showAlert = true
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Missing Information"),
                      message: Text(viewModel.alertMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

extension Gender: CustomStringConvertible {
    public var description: String { rawValue }
}

extension WeightUnit: CustomStringConvertible {
    public var description: String { rawValue }
}

extension HeightUnit: CustomStringConvertible {
    public var description: String { rawValue }
}


#Preview {
    BabyRegistrationForm()
}
