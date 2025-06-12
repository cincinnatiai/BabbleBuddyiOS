//
//  BBCardSectionViewContainer.swift
//  DesignKit
//
//  Created by Noel Hiram Pat Angulo on 6/11/25.
//

import SwiftUI

/// To use it you can call it like this:
///
/// BBCardSectionViewContainer { The views you need inside the cardView }
///
/// If you want the card with a section title call it like this
///
///BBCardSectionViewContainer(title: The string section title, icon: A Image leading icon) { The views you need inside the cardView }

public struct BBCardSectionViewContainer<Content: View>: View {
    let title: String?
    let icon: Image?
    let content: () -> Content

    // MARK: Dimensions
    private let verticalSpacing: CGFloat = 16
    private let titleAndIconHorizontalSpacing: CGFloat = 16
    private let cardCornerRadius: CGFloat = 16

    public init(
        title: String? = nil,
        icon: Image? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.icon = icon
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: verticalSpacing) {
            if let title = title {
                HStack(spacing: titleAndIconHorizontalSpacing) {
                    if let icon = icon {
                        icon
                            .foregroundColor(.gray)
                    }
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
            }

            content()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cardCornerRadius)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
        )
    }
}
