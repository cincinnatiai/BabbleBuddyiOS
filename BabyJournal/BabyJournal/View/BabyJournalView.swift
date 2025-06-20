import SwiftUI
import DesignKit

// MARK: Journal Entries view needs to be developed
public struct BabyJournalView: View {
    @State private var showBottomSheet = false

    public var body: some View {
        ZStack {
            Text("Journal Entries")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGroupedBackground))

            VStack {
                Spacer()
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
        }
        .sheet(isPresented: $showBottomSheet) {
            BBBottomSheetView(title: "Select an event") {_ in 
                ForEach(EventType.allCases, id: \.self) { type in
                    BBJournalEventItem(type: type) {
                        print("Selected event: \(type.rawValue)")
                        showBottomSheet = false
                    }
                }
            }
            .presentationDetents([.medium, .large])
        }
    }

    public init() {}
}

#Preview {
    BabyJournalView()
}
