//
//  TabBarItemsProvider.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 6/10/25.
//

import SwiftUI
import TabBar
import AuthLibrarySPM

typealias L10n = LocalizedStringKeys

enum TabBarItemsProvider {
    /// TabBarItemsProvider.Items() will inject to the TabBar Module the items on the tab bar navigation  bar, the order of the items is determined
    /// with their position of the Items() array
    static func items() -> [TabItem] {
        return [
            TabItem(
                title: L10n.HomeScreenTabItemTitle,
                icon: "house",
                view: HomeScreen()
            ),
            TabItem(
                title: L10n.SettingsScreenTabItemTitle,
                icon: "gearshape",
                view: SettingsView()
            )
        ]
    }
}
