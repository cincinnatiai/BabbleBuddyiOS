import SwiftUICore
import SwiftUI
import DesignKit

private var localizedStrings: BabyJournalLocalizedStringKeys.Type { BabyJournalLocalizedStringKeys.self }

enum FeedingType: String, CaseIterable {
    case breastmilk, formula, solid
}

struct FeedEventForm: View {
    @Binding var feedingType: String

    var body: some View {
        Picker(localizedStrings.EventFormsFeedingType, selection: $feedingType) {
            ForEach(FeedingType.allCases, id: \.rawValue) {
                Text($0.rawValue.capitalized).tag($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct DiaperEventForm: View {
    @Binding var diaperDetails: String
    
    var body: some View {
        BBTextfield(inputPlaceHolder: localizedStrings.EventFormsDiaperDetails, inputBinder: $diaperDetails)
    }
}

struct SleepEventForm: View {
    @Binding var sleepQuality: String
    
    var body: some View {
        BBTextfield(inputPlaceHolder: localizedStrings.EventFormsSleepQuality, inputBinder: $sleepQuality)
    }
}

struct PlayEventForm: View {
    @Binding var activityDetails: String
    
    var body: some View {
        BBTextfield(inputPlaceHolder: localizedStrings.EventFormsActivityDetails, inputBinder: $activityDetails)
    }
}

struct CryingEventForm: View {
    @Binding var cryingReason: String
    
    var body: some View {
        BBTextfield(inputPlaceHolder: localizedStrings.EventFormsCryingReason, inputBinder: $cryingReason)
    }
}

struct MeasurementEventForm: View {
    @Binding var temperature: String
    
    var body: some View {
        BBTextfield(inputPlaceHolder: localizedStrings.EventFormsTemperature, inputBinder: $temperature)
    }
}
