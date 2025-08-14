import SwiftUI

public struct BBBottomSheetView: View {
    private let verticalSpacing: CGFloat = 16
    private let itemSpacing: CGFloat = 8
    private let cornerRadius: CGFloat = 20
    private let topPadding: CGFloat = 16

    let title: String
    let onTapEvent: (EventType) -> Void
    @State private var showMoreEvents = false

    public init(title: String, onTapEvent: @escaping (EventType) -> Void) {
        self.title = title
        self.onTapEvent = onTapEvent
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: verticalSpacing) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.top, topPadding)

            VStack(spacing: itemSpacing) {
                let items = showMoreEvents ? EventType.secondary : EventType.primary
                ForEach(items, id: \.self) { type in
                    BBJournalEventItem(type: type) {
                        switch type {
                        case .more:
                            withAnimation { showMoreEvents = true }
                        case .less:
                            withAnimation { showMoreEvents = false }
                        default:
                            onTapEvent(type)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(cornerRadius)
    }
}

#Preview {
    BBBottomSheetView(title: "Add Event") { event in
        print("Tapped:", event)
    }
}
