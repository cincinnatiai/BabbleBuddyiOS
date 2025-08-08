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

typealias L10n = LocalizedStringKeys

enum TabBarItemsProvider {
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
                viewController: SettingsScreen()
            ),
            TabItem(
                title: "Sign out",
                icon: "bookmark",
                view: SettingsView()
            )
        ]
    }
}
