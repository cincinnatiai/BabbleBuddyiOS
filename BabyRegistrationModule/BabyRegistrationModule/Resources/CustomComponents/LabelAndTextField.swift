//
//  LabelAndTextField.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/23/25.
//

import Foundation
import SwiftUI

public struct LabelAndTextField: View {
    
    var title: String
    var inputPlaceHolder: String
    @Binding var inputBinder: String
    
    public var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            TextField(inputPlaceHolder, text: $inputBinder)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    LabelAndTextField(title: "Title", inputPlaceHolder: "PlaceHolder", inputBinder: .constant(""))
}
