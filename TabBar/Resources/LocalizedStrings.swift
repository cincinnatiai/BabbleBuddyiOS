import Foundation

// MARK: - String Extension for Localization

/// Adds `.localized` computed property to simplify localized string lookups.
/// Uses `tabBarModule` bundle, allowing localization in modular apps.
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .tabBarModule, comment: "")
    }
}

// MARK: - Tab Bar Localized String Keys

/// Centralized static keys for localized strings used in the TabBar module.
enum TabBarLocalizedStringKeys {
    static let TabBarViewErrorAlertTitle = "TAB_BAR_VIEW_ERROR_ALERT_TITLE".localized
    static let TabBarViewErrorAlertButton = "TAB_BAR_VIEW_ERROR_ALERT_BUTTON".localized

    static let TabBarViewModelSettingsScreenTitle = "TAB_BAR_VIEW_MODEL_SETTINGS_SCREEN_TITLE".localized
    static let TabBarViewModelHomeScreenTitle = "TAB_BAR_VIEW_MODEL_HOME_SCREEN_TITLE".localized
    static let TabBarViewModelDefaultScreenTitle = "TAB_BAR_VIEW_MODEL_DEFAULT_SCREEN_TITLE".localized
    static let FatalErrorMessage = "FATAL_ERROR_MESSAGE".localized
}

/// Not used, these icons now are deprecated because the parent app is injecting it to the library

// MARK: - Tab Bar Icons

/// Centralized definition of SF Symbol pairs (default and selected) per tab.
enum TabBarIcons {
    static let home = ("house", "house.fill")
    static let settings = ("gearshape", "gearshape.fill")
    static let babies = ("figure.and.child.holdinghands", "figure.and.child.holdinghands")
    static let unknown = ("questionmark.circle", "questionmark.circle.fill")
}

// MARK: - Tab Bar Item Keys

/// Enum representing valid tab keys used throughout the tab bar setup.
/// Raw values must match the string keys injected by ViewLoaderViewModel.
enum TabBarItemKey: String {
    case home = "home"
    case settings = "settings"
    case babies = "babiesList"
}
