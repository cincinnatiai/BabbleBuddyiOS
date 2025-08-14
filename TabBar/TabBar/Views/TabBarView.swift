import UIKit
import SwiftUI
import SettingsModule

public struct TabBarView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    private let tabsProvider: () -> [TabItem]

    public init(tabsProvider: @escaping () -> [TabItem]) {
        self.tabsProvider = tabsProvider
    }

    public var body: some View {
        let tabs = tabsProvider()
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
            let nav = UINavigationController(rootViewController: vc)
            ViewControllerWrapper(viewController: nav)
        }
    }
}
