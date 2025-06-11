//
//  LocalizedStrings.swift
//  TabBar
//
//  Created by Trainee on 4/3/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .tabBarModule, comment: "")
    }
}

enum TabBarLocalizedStringKeys {
    static let TabBarViewErrorAlertTitle = "TAB_BAR_VIEW_ERROR_ALERT_TITLE".localized
    static let TabBarViewErrorAlertButton = "TAB_BAR_VIEW_ERROR_ALERT_BUTTON".localized
    static let TabBarViewModelSettingsScreenTitle = "TAB_BAR_VIEW_MODEL_SETTINGS_SCREEN_TITLE".localized
    static let TabBarViewModelHomeScreenTitle = "TAB_BAR_VIEW_MODEL_HOME_SCREEN_TITLE".localized
    static let TabBarViewModelDefaultScreenTitle = "TAB_BAR_VIEW_MODEL_DEFAULT_SCREEN_TITLE".localized
    static let FatalErrorMessage = "FATAL_ERROR_MESSAGE".localized
}

/// Not used, these icons now are deprecated because the parent app is injecting it to the library
enum TabBarIcons {
    static let home = ("house", "house.fill")
    static let settings = ("gearshape", "gearshape.fill")
    static let unknown = ("questionmark.circle", "questionmark.circle.fill")
}

enum TabBarItemKey: String {
    case home = "home"
    case settings = "settings"
}
