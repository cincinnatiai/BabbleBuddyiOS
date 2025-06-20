import SwiftUI

/// Represents a tappable journal event row with icon and label.
public struct BBJournalEventItem: View {
    // MARK: - Properties

    let type: EventType
    let onTap: () -> Void

    // MARK: - Init

    public init(type: EventType, onTap: @escaping () -> Void) {
        self.type = type
        self.onTap = onTap
    }

    // MARK: - Body

    public var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                Image(systemName: iconName(for: type))
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.accentColor)
                Text(type.rawValue.capitalized)
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }

    // MARK: - Helpers

    private func iconName(for type: EventType) -> String {
        switch type {
        case .feed: return "fork.knife.circle"
        case .pee: return "drop.fill"
        case .poop: return "leaf.fill"
        case .sleep: return "bed.double.fill"
        case .play: return "soccerball.inverse"
        case .weight: return "scalemass.fill"
        case .height: return "ruler"
        case .headSize: return "person.crop.square"
        }
    }
}
