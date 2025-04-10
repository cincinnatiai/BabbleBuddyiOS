import SwiftUI

struct BabyRegistrationForm: View {
    @StateObject private var viewModel = BabyRegistrationViewModel()

    var body: some View {
        VStack {
            Text("Baby Registration Form").bold()
        }
        Form {
            DKTextField("First Name", text: $viewModel.baby.firstName)
            DKTextField("Last Name", text: $viewModel.baby.lastName)
            DKDatePicker("Date of Birth", date: $viewModel.baby.dateOfBirth)
            DKPicker("Gender", options: Gender.allCases, selection: $viewModel.baby.gender)

            HStack {
                DKTextField("Weight", text: Binding(
                    get: { String(viewModel.baby.weight) },
                    set: { viewModel.baby.weight = Double($0) ?? 0.0 }
                ), keyboard: .decimalPad)

                DKPicker("", options: WeightUnit.allCases, selection: $viewModel.baby.weightUnit)
            }

            HStack {
                DKTextField("Height", text: Binding(
                    get: { String(viewModel.baby.height) },
                    set: { viewModel.baby.height = Double($0) ?? 0.0 }
                ), keyboard: .decimalPad)

                DKPicker("", options: HeightUnit.allCases, selection: $viewModel.baby.heightUnit)
            }

            DKTextField("Blood Type", text: $viewModel.baby.bloodType)

            VStack {
                ForEach(viewModel.baby.allergies, id: \.self) { allergy in
                    TextField("Allergy", text: Binding(
                        get: { allergy },
                        set: { newValue in
                            if let index = viewModel.baby.allergies.firstIndex(of: allergy) {
                                viewModel.baby.allergies[index] = newValue
                            }
                        }
                    ))
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                }
                Button(action: {
                    viewModel.baby.allergies.append("")
                } ) {
                    Text("Add Allergy")
                        .foregroundColor(.blue)
                }
            }

            DKButton("Submit") {
                if !viewModel.validateForm() {
                    viewModel.showAlert = true
                } else {
                    viewModel.saveBabyLocally()
                }
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(title: Text("Missing Information"),
                      message: Text(viewModel.alertMessage),
                      dismissButton: .default(Text("OK")))
            })
        }
        .navigationBarTitle("Baby Registration")
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
