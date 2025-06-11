//
//  TabBarItemModel.swift
//  TabBar
//
//  Created by Noel Hiram Pat Angulo on 6/10/25.
//

import SwiftUI
import UIKit

enum TabContent {
    case swiftUIView(AnyView)
    case viewController(UIViewController)
}

public struct TabItem {
    let title: String
    let icon: String
    let content: TabContent

    public init<V: View>(title: String, icon: String, view: V) {
        self.title = title
        self.icon = icon
        self.content = .swiftUIView(AnyView(view))
    }

    public init(title: String, icon: String, viewController: UIViewController) {
        self.title = title
        self.icon = icon
        self.content = .viewController(viewController)
    }
}
