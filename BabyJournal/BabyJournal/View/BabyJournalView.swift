import SwiftUI
import DesignKit
import SettingsModule

public struct BabyJournalView: View {
    @ObservedObject private var viewModel: BabyJournalViewModel
    @State private var activeModal: JournalModalType? = nil
    @State private var selectedBabyName: String = ""
    @State private var selectedBabyIndex: Int = 0
    @State private var selectedDate: Date = Date()
    @ObservedObject var languageManager = LanguageManager.shared
    private var localizedStrings: BabyJournalLocalizedStringKeys.Type { BabyJournalLocalizedStringKeys.self }

    public init(viewModel: BabyJournalViewModel){
        self.viewModel = viewModel
    }

    public var body: some View {
        screenContent
            .sheet(item: $activeModal) { modal in
                switch modal {
                case .bottomSheet:
                    BBBottomSheetView(title: localizedStrings.BabyJournalViewSelectEventTitle) { event in
                        if let createRequest = viewModel.makeJournalRequest(
                            event: event,
                            selectedBabyIndex: selectedBabyIndex,
                            selectedDate: selectedDate
                        ){
                            Task {
                                await viewModel.createJournalData(request: createRequest)
                            }
                        }
                        activeModal = nil
                    }
                    .presentationDetents([.medium])
                    
                case .eventDetail(let event):
                    EventModalView(
                        event: event,
                        selectedBabyIndex: selectedBabyIndex,
                        selectedDate: selectedDate,
                        viewModel: viewModel,
                        onClose: {
                            activeModal = nil
                        }
                        
                    )
                    .presentationDetents([.large])
                }
            }
    }

    @ViewBuilder
    private var screenContent: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .frame(alignment: .center)
        case .loaded(let babies, let events):
            screen(babies: babies, events: events)
        case .noBabies:
            EmptyView()
        case .error(error: let error):
            Text("\(localizedStrings.BabyJournalViewErrorTitle) \(error)")
        }
    }

    private func screen(babies: [String], events: [BabyEventDisplayableInfo]) -> some View {
        ZStack(alignment: .bottomTrailing) {
            BBVStack(screenTitle: localizedStrings.BabyJournalViewScreenTitle) {
                topContent(babies: babies)
                Divider()
                bodyContent(events: events)
            }
            BBHStack{
                Spacer()
                BBFloatingActionButton(iconName: "plus") {
                    activeModal = .bottomSheet
                }
            }
            .padding()
        }
        .background(AppColor.background.ignoresSafeArea())
    }

    @ViewBuilder
    private func topContent(babies: [String]) -> some View {
        BBHStack {
            BBWheelPicker(
                options: babies,
                selected: $selectedBabyName,
                title: babies[0],
                doneButtonLabel: localizedStrings.BabyJournalViewSelectTitle
            ) { index in
                selectedBabyIndex = index
                viewModel
                    .createJournalFetchRequest(
                        selectedBabyIndex: index,
                        selectedDate: selectedDate
                    )
            }
            BBDatePicker(selectedDate: $selectedDate){
                viewModel
                    .createJournalFetchRequest(
                        selectedBabyIndex: selectedBabyIndex,
                        selectedDate: selectedDate
                    )
            }
        }
        .onAppear {
            if selectedBabyName.isEmpty, let first = babies.first {
                selectedBabyName = first
            }
        }
    }

    @ViewBuilder
    private func bodyContent(events: [BabyEventDisplayableInfo]) -> some View {
        if events.isEmpty {
            Spacer()
            EmptyStateView(
                title: localizedStrings.BabyJournalViewNoEventsTitle,
                message: localizedStrings.BabyJournalViewAddEventsTitle
            )
        } else {
            ForEach(events.indices, id: \.self) { index in
                let event = events[index]
                BBCardView(
                    name: event.eventType,
                    description: event.eventDate,
                    type: .event(.eat),
                    onEdit: {}, // TODO: Vlad will implement the Edit button
                    onDelete: {}, // TODO: Vlad will implement the Delete button
                    onTap: {
                        activeModal = .eventDetail(event: event)
                    }
                )
            }
        }
    }
}
