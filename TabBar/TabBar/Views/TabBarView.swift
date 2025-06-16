import UIKit
import SwiftUI

public struct TabBarView: View {
    private let tabs: [TabItem]

    public init(tabs: [TabItem]) {
        self.tabs = tabs
    }

    public var body: some View {
        TabView {
            ForEach(Array(tabs.enumerated()), id: \.offset) { _, tab in
                tabContentView(tab)
                    .tabItem {
                        Image(systemName: tab.icon)
                        Text(tab.title)
                    }
            }
        }
    }

    @ViewBuilder
    private func tabContentView(_ tab: TabItem) -> some View {
        switch tab.content {
        case .swiftUIView(let view):
            NavigationStack {
            view
            }
        case .viewController(let vc):
            ViewControllerWrapper(viewController: vc)
        }
    }
}
