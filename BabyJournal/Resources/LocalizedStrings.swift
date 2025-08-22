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
    // MARK: Event Modal View
    static var EventModalViewScreenTitle: String { "EventModalView_Screen_Title".localized}
    static var EventModalViewEventInfo: String {"EventModalView_Event_Info".localized}
    static var EventModalViewType: String {"EventModalView_Type".localized}
    static var EventModalViewDate: String {"EventModalView_Date".localized}
    static var EventModalViewDetails: String {"EventModalView_Details".localized}
    static var EventModalViewUnknownEventType: String {"EventModalView_Unknown_Event_Type".localized}
    static var EventModalViewButtonSave: String {"EventModalView_Button_Save".localized}
    static var EventModalViewButtonDelete: String {"EventModalView_Button_Delete".localized}
    static var EventModalViewButtonCancel: String {"EventModalView_Button_Cancel".localized}
    static var EventModalViewMood: String {"EventModalView_Mood".localized}
    // MARK: - Event Forms
    static var EventFormsFeedingType: String {"EventForms_Feeding_Type".localized}
    static var EventFormsDiaperDetails: String {"EventForms_Diaper_Dietels".localized}
    static var EventFormsSleepQuality: String {"EventForms_Sleep_Quality".localized}
    static var EventFormsActivityDetails: String {"EventForms_Activity_Details".localized}
    static var EventFormsCryingReason: String {"EventForms_Crying_Reason".localized}
    static var EventFormsTemperature: String { "EventForms_Temperature".localized}
}
