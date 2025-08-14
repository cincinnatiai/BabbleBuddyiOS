//
//  BBVStack.swift
//  DesignKit
//
//  Created by Noel Hiram Pat Angulo on 6/11/25.
//

import SwiftUI

/// Use this by calling BBVStack {
/// Add here your screen content
/// }
///
/// If you want the screen with its own title use it like this
///
///BBVStack(screenTitle: "Your screen title") {
/// Add here your screen content
/// }
///
/// The navigation to the view should be wrapped into the NavigationStack { View }, otherwise the title is not going to be displayed

public struct BBVStack<Content: View>: View {
    private let content: () -> Content
    private let scrollable: Bool

    // MARK: Dimensions
    private let horizontalPaddding: CGFloat = 24
    private let topPadding: CGFloat = 10
    private let bottomPadding: CGFloat = 80
    private let verticalSpacing: CGFloat = 16
    private let screenTitle: String?

    // MARK: Initializer
    public init(
        screenTitle: String? = nil,
        scrollable: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.screenTitle = screenTitle
        self.scrollable = scrollable
        self.content = content
    }

    public var body: some View {
        if scrollable {
            ScrollView(showsIndicators: false) {
                screenContent()
            }
        } else {
            screenContent()
        }
    }

    @ViewBuilder
    private func screenContent() -> some View {
        VStack(alignment: .center, spacing: verticalSpacing) {
            content()
        }
        .padding(.horizontal, horizontalPaddding)
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
        .applyIf(screenTitle != nil) { view in
            view.navigationTitle(screenTitle!)
        }
    }
}

extension View {
    @ViewBuilder
    func applyIf<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
