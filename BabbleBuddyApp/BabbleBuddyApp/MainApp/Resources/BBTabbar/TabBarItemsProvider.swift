//
//  TabBarItemsProvider.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 6/10/25.
//

import SwiftUI
import TabBar
import AuthLibrarySPM
import BabyJournal

typealias L10n = LocalizedStringKeys

enum TabBarItemsProvider {
    /// TabBarItemsProvider.Items() will inject to the TabBar Module the items on the tab bar navigation  bar, the order of the items is determined
    /// with their position of the Items() array
    static func items(userEmail: String) -> [TabItem] {
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
                    .makeBabiesListView(userEmail: userEmail)
            ),
            TabItem(
                title: L10n.SettingsScreenTabItemTitle,
                icon: "gearshape",
                view: SettingsView()
            )
        ]
    }
}
