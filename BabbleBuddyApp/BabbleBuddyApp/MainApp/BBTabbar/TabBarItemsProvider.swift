//
//  TabBarItemsProvider.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 6/10/25.
//

import SwiftUI
import TabBar
import AuthLibrarySPM
import SettingsModule

enum TabBarItemsProvider {
    private static var L10n: LocalizedStringKeys.Type { LocalizedStringKeys.self }
    /// Use the TabItem from the TabBar module
    static func items() -> [TabItem] {
        return [
            TabItem(
                title: L10n.HomeScreenTabItemTitle,
                icon: "book.pages",
                view: TabBarScreenProvider.makeJournalView()
            ),
            TabItem(
                title: L10n.BabiesListTabItemTitle,
                icon: "figure.and.child.holdinghands",
                viewController: TabBarScreenProvider
                    .makeBabiesListView()
            ),
            TabItem(
                title: L10n.SettingsScreenTabItemTitle,
                icon: "gearshape",
                view: SettingsScreen()
            ),
            TabItem(
                title: L10n.SignOutTabItemTitle,
                icon: "bookmark",
                view: SettingsView()
            )
        ]
    }
}
