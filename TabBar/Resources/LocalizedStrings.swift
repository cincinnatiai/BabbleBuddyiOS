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
    
    enum TabBarLocalizedStringKeys {
        static let TabBarViewErrorAlertTitle = "TabBarView_ErrorAlert_Title".localized
        static let TabBarViewErrorAlertButton = "TabBarView_ErrorAlert_Button".localized
        static let TabBarViewModelSettingsScreenTitle = "TabBarViewModel_SettingsScreen_Title".localized
        static let TabBarViewModelHomeScreenTitle = "TabBarViewModel_HomeScreen_Title".localized
        static let TabBarViewModelDefaultScreenTitle = "TabBarViewModel_DefaultScreen_Title".localized
        static let FatalErrorMessage = "FatalError_Message".localized
        static let Test = "Test".localized
        
    }
}
