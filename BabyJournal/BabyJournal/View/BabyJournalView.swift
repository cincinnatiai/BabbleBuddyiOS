import SwiftUI
import DesignKit

public struct BabyJournalView: View {
    @ObservedObject private var viewModel: BabyJournalViewModel
    @State private var showBottomSheet = false
    @State private var selectedBabyName: String = ""
    @State private var selectedBabyIndex: Int = 0
    @State private var selectedDate: Date = Date()

    public init(viewModel: BabyJournalViewModel){
        self.viewModel = viewModel
    }

    public var body: some View {
        screenContent
            .sheet(isPresented: $showBottomSheet) {
                BBBottomSheetView(title: "Select an event"){ event in
                    viewModel
                        .createJournalCreateRequest(
                            event: event,
                            selectedBabyIndex: selectedBabyIndex, selectedDate: selectedDate
                        )
                    showBottomSheet = false
                }
                .presentationDetents([.medium])
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
            Text("Error: \(error)")
        }
    }

    private func screen(babies: [String], events: [BabyEventDisplayableInfo]) -> some View {
        ZStack(alignment: .bottomTrailing) {
            BBVStack(screenTitle: "Baby Journal") {
                topContent(babies: babies)
                Divider()
                bodyContent(events: events)
            }
            BBHStack{
                Spacer()
                BBFloatingActionButton(iconName: "plus") {
                    showBottomSheet = true
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
                doneButtonLabel: "Select"
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
                title: "No events",
                message: "Please add events to your journal"
            )
        } else {
            ForEach(events.indices, id: \.self) { index in
                let event = events[index]
                BBCardView(
                    name: event.eventType,
                    description: event.eventDate,
                    type: .event(.feed)
                )
            }
        }
    }
}
