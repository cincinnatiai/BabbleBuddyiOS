//
//  BBHStack.swift
//  DesignKit
//
//  Created by Noel Hiram Pat Angulo on 6/11/25.
//

import SwiftUI

/// To use it call it like this:
/// BBHStack { The views you need in a row }

public struct BBHStack<Content: View>: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
