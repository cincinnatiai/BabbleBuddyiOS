//
//  LocalizedStrings.swift
//  BabiesList
//
//  Created by Trainee on 4/21/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .babiesListModule, comment: "")
    }
}

enum BabiesListLocalizedStringKeys {
    static let FatalErrorMessage = "Fatal_Error_Message".localized
    static let BabyTableViewCellDateOfBirthLabel = "BabyTableViewCell_DateOfBirth_Label".localized
    static let BabiesListViewAlertMessageTitle = "BabiesListView_AlertMessage_Title".localized
    static let BabiesListViewAlertActionLabel = "BabiesListView_AlertAction_Label".localized
}
