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

    // MARK: - Layout Constants
    private let verticalSpacing: CGFloat = 16
    private let titleAndIconSpacing: CGFloat = 16
    private let cornerRadius: CGFloat = 16
    private let iconSize: CGFloat = 48

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
                BBHStack {
                    if let icon = icon {
                        icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding(6)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
            }
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
        )
    }
}
