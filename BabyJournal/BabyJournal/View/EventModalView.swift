import SwiftUI
import DesignKit

struct EventModalView: View {
    let event: BabyEventDisplayableInfo
    let selectedBabyIndex: Int
    let selectedDate: Date
    @ObservedObject var viewModel: BabyJournalViewModel
    let onClose: () -> Void
    private var localizedStrings: BabyJournalLocalizedStringKeys.Type { BabyJournalLocalizedStringKeys.self }

    // MARK: - Editable State

    @State private var notes = ""
    @State private var mood = ""
    @State private var temperature = ""
    @State private var feedingType = ""
    @State private var diaperDetails = ""
    @State private var sleepQuality = ""
    @State private var cryingReason = ""
    @State private var activityDetails = ""

    // MARK: - Derived

    private var eventType: EventType? {
        EventType(rawValue: event.eventType.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ScrollView {
                BBVStack() {
                    eventInfoSection
                    eventDetailsSection
                    actionButtons
                }
                .padding()
            }
            .navigationTitle(localizedStrings.EventModalViewScreenTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: populateExistingValues)
            if case .loading = viewModel.state {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
        }
    }
}
// MARK: - Event Info Section

private extension EventModalView {
    var eventInfoSection: some View {
        BBCardSectionViewContainer(title: localizedStrings.EventModalViewEventInfo, icon: Image(systemName: "calendar")) {
            Text( localizedStrings.EventModalViewType + (event.eventType.capitalized))
            Text(localizedStrings.EventModalViewDate + (event.eventDate))
        }
    }
}

// MARK: - Details Section

private extension EventModalView {
    var eventDetailsSection: some View {
        BBCardSectionViewContainer(title: localizedStrings.EventModalViewDetails, icon: Image(systemName: "pencil")) {
            MoodPicker(mood: $mood)

            switch eventType {
            case .eat:
                FeedEventForm(feedingType: $feedingType)
            case .pee, .poop:
                DiaperEventForm(diaperDetails: $diaperDetails)
            case .sleep, .sleep_start, .sleep_end:
                SleepEventForm(sleepQuality: $sleepQuality)
            case .play:
                PlayEventForm(activityDetails: $activityDetails)
            case .more, .less:
                CryingEventForm(cryingReason: $cryingReason)
            case .weight, .height, .head_circumference:
                MeasurementEventForm(temperature: $temperature)
            case .none:
                Text(localizedStrings.EventModalViewUnknownEventType)
            }
        }
    }
}
// MARK: - Action Buttons

private extension EventModalView {
    private var isLoading: Bool {
        if case .loading = viewModel.state { return true }
        return false
    }
    var actionButtons: some View {
        Group {
            Button(localizedStrings.EventModalViewButtonSave) {
                handleSave()
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)

            Button(localizedStrings.EventModalViewButtonDelete, role: .destructive) {
                handleDelete()
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)

            Button(localizedStrings.EventModalViewButtonCancel, role: .cancel, action: onClose)
                .padding(.top)
                .disabled(isLoading)
        }
    }

    func handleSave() {
        Task {
             viewModel.handleSaveEventUpdate(
                event: event,
                eventType: eventType,
                selectedBabyIndex: selectedBabyIndex,
                selectedDate: selectedDate,
                requestBody: BabyEventBodyModel(
                    notes: notes,
                    mood: mood,
                    temperature: temperature,
                    feedingType: feedingType,
                    diaperDetails: diaperDetails,
                    sleepQuality: sleepQuality,
                    cryingReason: cryingReason,
                    activityDetails: activityDetails
                ),
                onClose: onClose
            )
        }
    }

    func handleDelete() {
        Task {
            viewModel.handleDeleteEvent(event: event)
            onClose()
        }
    }
}
// MARK: - Value Binding Setup

private extension EventModalView {
    func populateExistingValues() {
        notes = event.notes ?? ""
        mood = event.mood ?? ""
        temperature = event.temperature ?? ""
        feedingType = event.feedingType ?? ""
        diaperDetails = event.diaperDetails ?? ""
        sleepQuality = event.sleepQuality ?? ""
        cryingReason = event.cryingReason ?? ""
        activityDetails = event.activityDetails ?? ""
    }
}
