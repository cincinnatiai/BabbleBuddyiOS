//
//  DKDatePicker.swift
//  DesignKit
//
//  Created by CincinnatiAI Dallas on 4/2/25.
//

import SwiftUI

public struct DKDatePicker: View {
    public var title: String
    @Binding public var date: Date

    public init(_ title: String, date: Binding<Date>) {
        self.title = title
        self._date = date
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
        }
    }
}
