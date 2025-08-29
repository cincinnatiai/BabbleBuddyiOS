import SwiftUI

private var localizedStrings: BabyJournalLocalizedStringKeys.Type { BabyJournalLocalizedStringKeys.self }

enum Mood: String, CaseIterable {
    case happy, sad, angry, tired, calm
}

struct MoodPicker: View {
    @Binding var mood: String

    var body: some View {
        Picker(localizedStrings.EventModalViewMood, selection: $mood) {
            ForEach(Mood.allCases, id: \.rawValue) {
                Text($0.rawValue.capitalized).tag($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}
