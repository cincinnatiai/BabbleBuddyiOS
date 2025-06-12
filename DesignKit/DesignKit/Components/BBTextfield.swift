//
//  LabelAndTextField.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/23/25.
//

import Foundation
import SwiftUI

/// To  use this call it like this:
///
/// BBTextfield(title: A value rendered above the texfield and can be nil, inputPlaceHolder: A value rendered as a place holder inside the textfield,
/// inputBinder: The value that handles or receive the input text, keyboardType: The type of keyboard that will appear for the user, titleAligment: If the title is visible this determine its aligment on the screen)

public struct BBTextfield: View {
    private let title: String?
    private let inputPlaceHolder: String
    @Binding private var inputBinder: String
    private let keyboardType: UIKeyboardType
    private let titleAlignment: Alignment

    @FocusState private var isFocused: Bool

    // MARK: Dimensions

    private let spaceBetweenTitleAndTextField: CGFloat = 6
    private let textFieldPadding: EdgeInsets = EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
    private let textFieldCornerRadius: CGFloat = 10
    private let componentPadding: CGFloat = 4

    public init(
        title: String? = nil,
        inputPlaceHolder: String,
        inputBinder: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        titleAlignment: Alignment = .leading
    ) {
        self.title = title
        self.inputPlaceHolder = inputPlaceHolder
        self.keyboardType = keyboardType
        self.titleAlignment = titleAlignment
        self._inputBinder = inputBinder
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: spaceBetweenTitleAndTextField) {
            if let title = title {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: titleAlignment)
            }

            TextField(inputPlaceHolder, text: $inputBinder)
                .keyboardType(keyboardType)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($isFocused)
                .padding(textFieldPadding)
                .background(
                    RoundedRectangle(cornerRadius: textFieldCornerRadius)
                        .stroke(isFocused ? Color.accentColor : Color.gray.opacity(0.3), lineWidth: isFocused ? 1.8 : 1)
                        .background(
                            RoundedRectangle(
                                cornerRadius: textFieldCornerRadius
                            )
                                .fill(Color(.secondarySystemBackground))
                        )
                )
                .animation(.easeInOut(duration: 0.2), value: isFocused)
        }
        .padding(.vertical, componentPadding)
    }
}


#Preview {
    BBTextfield(title: "Title", inputPlaceHolder: "PlaceHolder", inputBinder: .constant(""))
}
