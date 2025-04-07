//
//  DKPicker.swift
//  DesignKit
//
//  Created by CincinnatiAI Dallas on 4/2/25.
//

import SwiftUI

public struct DKPicker<T: Hashable & Identifiable>: View where T: CustomStringConvertible {
    public var title: String
    public var options: [T]
    @Binding public var selection: T

    public init(_ title: String, options: [T], selection: Binding<T>) {
        self.title = title
        self.options = options
        self._selection = selection
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
            Picker(title, selection: $selection) {
                ForEach(options) { option in
                    Text(option.description).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}
