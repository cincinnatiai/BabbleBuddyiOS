//
//  BBDropDown.swift
//  DesignKit
//
//  Created by Noel Hiram Pat Angulo on 6/11/25.
//

import SwiftUI

/// To use this call it this way:
///
/// BBWheelPicker(options: [Array of string options], selected: The value that receive the selected value, title: The label displeyd by default, doneButtonLabel: The label of the button that select a value)

public struct BBWheelPicker: View {
    private let options: [String]
    @Binding var selected: String
    private let title: String
    private let doneButtonLabel: String
    private var onSelection: (Int) -> Void = {_ in}

    @State private var isPresented = false
    @State private var internalSelectedIndex: Int = 0

    // MARK: Dimensions
    private let selectorCornerRadius: CGFloat = 10
    private let pickerFrameMaxHeight: CGFloat = 200

    public init(options: [String], selected: Binding<String>, title: String, doneButtonLabel: String,
                onSelection: @escaping (Int) -> Void = {_ in}) {
        self.options = options
        self._selected = selected
        self.title = title
        self.doneButtonLabel = doneButtonLabel
        self.onSelection = onSelection
    }

    public var body: some View {
        Button(action: {
            if let initialIndex = options.firstIndex(of: selected), !selected.isEmpty {
                internalSelectedIndex = initialIndex
            }
            isPresented.toggle()
        }) {
            HStack {
                Text(selected.isEmpty ? title : selected)
                    .foregroundColor(selected.isEmpty ? .gray : .primary)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: selectorCornerRadius)
                    .fill(Color(.secondarySystemBackground))
            )
        }
        .sheet(isPresented: $isPresented) {
            VStack {
                Spacer()
                Picker(selection: $internalSelectedIndex, label: Text("")) {
                    ForEach(options.indices, id: \.self) { index in
                        Text(options[index])
                            .tag(index)
                    }
                }
                .pickerStyle(.wheel)
                .labelsHidden()
                .frame(maxHeight: pickerFrameMaxHeight)

                Divider()

                Button(doneButtonLabel) {
                    if options.indices.contains(internalSelectedIndex) {
                        selected = options[internalSelectedIndex]
                        onSelection(internalSelectedIndex)
                    }
                    isPresented = false
                }
                .padding(.bottom)
            }
            .padding()
            .presentationDetents([.fraction(0.35)])
            .presentationDragIndicator(.visible)
        }
    }
}
