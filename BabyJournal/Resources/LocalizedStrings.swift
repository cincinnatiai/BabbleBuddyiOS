//
//  LocalizedStrings.swift
//  BabyJournal
//
//  Created by Cincinnati Ai on 8/13/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: .babyJournalModule, comment: "")
    }
}

enum BabyJournalLocalizedStringKeys {
    static var BabyJournalViewScreenTitle: String { "BabyJournalView_Screen_Title".localized }
    static var BabyJournalViewNoEventsTitle: String { "BabyJournalView_No_Events_Title".localized }
    static var BabyJournalViewAddEventsTitle: String { "BabyJournalView_Add_Events_Title".localized }
    static var BabyJournalViewSelectEventTitle: String { "BabyJournalView_Select_Event_Title".localized }
    static var BabyJournalViewSelectTitle: String { "BabyJournalView_Select_Title".localized }
    static var BabyJournalViewErrorTitle: String { "BabyJournalView_Error_Title".localized }
}
