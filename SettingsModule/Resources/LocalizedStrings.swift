//
//  LocalizedStrings.swift
//  SettingsModule
//
//  Created by Cincinnati Ai on 8/12/25.
//

import Foundation

// MARK: - String Extension for Localization

/// Adds `.localized` computed property to simplify localized string lookups.
/// Uses `settingsModule` bundle, allowing localization in modular apps.
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .settingsModule, comment: "")
    }
}

// MARK: - Settings Localized String Keys

/// Centralized static keys for localized strings used in the TabBar module.
enum SettingsLocalizedStringKeys {
    static var SettingsScreenTitle: String { "Settings_Screen_Title".localized }
    static var SettingsSectionTitle: String { "Settings_Section_Title".localized }
}
