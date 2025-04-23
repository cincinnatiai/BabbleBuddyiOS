//
//  CustomDatePicker.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/23/25.
//

import Foundation
import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date
    @State private var isPickerVisible = false
    
    var body: some View {
        VStack {
            HStack {
                Text(formattedDate(selectedDate))
                    .font(.body)
                Spacer()
                Button(action: {
                    withAnimation {
                        isPickerVisible.toggle()
                    }
                }) {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                }
            }
            .padding(.bottom)
            
            if isPickerVisible {
                VStack{
                    DatePicker ("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .clipped()
                    Button ("OK") {
                        withAnimation {
                            isPickerVisible = false
                        }
                    }
                }
                .padding(.top)
            }
        }
        .padding(.top)
    }
    
    private func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            return formatter.string(from: date)
        }
}

#Preview {
    @Previewable @State var selectedDate: Date = Date()
    CustomDatePicker(selectedDate: $selectedDate)
}
