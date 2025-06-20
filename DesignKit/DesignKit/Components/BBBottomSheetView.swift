import SwiftUI

public struct BBBottomSheetView: View {
    let title: String
    let onTapEvent: (EventType) -> Void

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    public init(title: String, onTapEvent: @escaping (EventType) -> Void) {
        self.title = title
        self.onTapEvent = onTapEvent
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.top)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(EventType.allCases, id: \.self) { type in
                    BBJournalEventItem(type: type) {
                        onTapEvent(type)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
    }
}

#Preview {
    BBBottomSheetView(title: "Add Event") { event in
        print("Tapped:", event)
    }
}
