//
//  DKTextField.swift
//  DesignKit
//
//  Created by CincinnatiAI Dallas on 4/2/25.
//

import SwiftUI

public struct DKTextField: View {
    public var title: String
    @Binding public var text: String
    public var keyboard: UIKeyboardType = .default

    public init(_ title: String, text: Binding<String>, keyboard: UIKeyboardType = .default) {
        self.title = title
        self._text = text
        self.keyboard = keyboard
    }

    public var body: some View {
        TextField(title, text: $text)
            .keyboardType(keyboard)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
    }
}
