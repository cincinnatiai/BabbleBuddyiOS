import SwiftUI
import DesignKit

// MARK: Journal Entries view needs to be developed
public struct BabyJournalView: View {
    @State private var showBottomSheet = false
    @State private var journalResults: [any BabyEventProtocol] = []

    private let service: BabyJournalServiceProtocol

    public init(service: BabyJournalServiceProtocol) {
        self.service = service
    }

    public var body: some View {
        // TODO: The account range key is the unique identifier of the baby, its retreieved from the fetchbabies api account range_key, all this logic needs to be moved to the view's viewmodel, down below is just a hard coded example to fetch the events
        let request = JournalRequestModel(
            accountPartitionKey: "CincinnatiBabyService",
            accountRangeKey:  "193daee5-480d-4329-89b0-f8e9dd561e79",
            userId: "",
            date: "2025-07-10",
            lastRangeKey: ""
        )

        return VStack {
            if !journalResults.isEmpty {
                ForEach(journalResults, id: \.rangeKey) { result in
                    VStack(alignment: .leading) {
                        Text("Type: \(result.type)")
                        Text("RangeKey: \(result.rangeKey)")
                    }
                }
            } else {
                Text("Loading...")
            }
            HStack {
                Spacer()
                FloatingActionButton(
                    iconName: "plus",
                    accessibilityLabel: "Add journal event",
                    action: {
                        showBottomSheet = true
                    }
                )
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
        }
        .onAppear {
            Task {
                do {
                    let response = try await service.fetchJournalByDate(request: request)
                    journalResults = response.results
                } catch {
                    print("ERROR:", error)
                }
            }
        }
        .sheet(isPresented: $showBottomSheet) {
            BBBottomSheetView(title: "Select an event") { selectedEvent in
                do {
                    let requestBody = BabyEventBodyModel(
                        unit: "",
                        notes: "",
                        duration: "",
                        mood: "",
                        temperature: "",
                        feedingType: "",
                        diaperDetails: "",
                        sleepQuality: "",
                        cryingReason: "",
                        activityDetails: ""
                    )

                    let bodyData = try JSONEncoder().encode(requestBody)
                    let bodyString = String(data: bodyData, encoding: .utf8)!

                    let request = BabyJournalEventRequestModel(
                        accountPartitionKey: "CincinnatiBabyService",
                        accountRangeKey: "193daee5-480d-4329-89b0-f8e9dd561e79",
                        body: bodyString,
                        dayDate: "2025-07-10",
                        file: "",
                        quantity: 0,
                        timestamp: "2025-07-10T04:46:00.000Z",
                        type: selectedEvent.eventName,
                        unit: "",
                        userId: "e2aff9ae-2102-4049-830e-912ec4b9a5b0"
                    )

                    Task {
                        do {
                            try await service.createJournalEntry(request: request)
                            showBottomSheet = false
                        } catch {
                            // TODO: HANDLE ERROR
                        }
                    }
                } catch {
                    // TODO: HANDLE JSON ENCODING ERROR, THIS SHOULD NOT BE NECESSARY WHEN MOVED TO THE VM
                }
            }
        }

    }
}
