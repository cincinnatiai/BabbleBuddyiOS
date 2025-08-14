//
//  CustomDatePicker.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/23/25.
//

import Foundation
import SwiftUI

/// To use this call it like this:
///
/// BBDatePicker(selectedDate: The value that handle or receive the selected date, closingButtonLabel: The string label that will be displayed to select and close the date picker)

public struct BBDatePicker: View {
    @Binding private var selectedDate: Date
    private let closingButtonLabel: String
    @State private var isPickerVisible = false
    private let onDateSelected: () -> Void

    public init(
        selectedDate: Binding<Date>,
        closingButtonLabel: String = "Select",
        onDateSelected: @escaping () -> Void = {}
    ) {
        _selectedDate = selectedDate
        self.closingButtonLabel = closingButtonLabel
        self.onDateSelected = onDateSelected
    }

    public var body: some View {
        HStack {
            Text(formattedDate(selectedDate))
                .font(.body)
            Button {
                isPickerVisible.toggle()
            } label: {
                Image(systemName: "calendar")
                    .imageScale(.large)
            }
        }
        .padding(.vertical)
        .sheet(isPresented: $isPickerVisible) {
            VStack(spacing: 16) {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .labelsHidden()

                Button(closingButtonLabel) {
                    isPickerVisible = false
                    onDateSelected()
                }
                .font(.headline)
            }
            .padding()
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    @Previewable @State var selectedDate: Date = Date()
    BBDatePicker(selectedDate: $selectedDate)
}
