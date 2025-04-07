//
//  DKButton.swift
//  DesignKit
//
//  Created by CincinnatiAI Dallas on 4/2/25.
//

import SwiftUI

public struct DKButton: View {
    public var title: String
    public var action: () -> Void

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
