import SwiftUI

/// Represents a tappable journal event row with icon and label.
public struct BBJournalEventItem: View {
    private let iconSize: CGFloat = 24
    private let spacing: CGFloat = 16
    private let verticalPadding: CGFloat = 8

    let type: EventType
    let onTap: () -> Void

    public init(type: EventType, onTap: @escaping () -> Void) {
        self.type = type
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            HStack(spacing: spacing) {
                Image(iconName(for: type))
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(.accentColor)
                Text(type.rawValue.capitalized)
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.vertical, verticalPadding)
        }
    }

    private func iconName(for type: EventType) -> String {
        switch type {
        case .feed: return "feeding-bottle"
        case .pee: return "pee-icon"
        case .poop: return "poop-icon"
        case .sleep: return "sleeping-icon"
        case .play: return "play-icon"
        case .weight: return "wheight-icon"
        case .height: return "height-icon"
        case .headSize: return "head-size"
        case .more: return "ellipsis.circle"
        case .less: return "chevron.up.circle"
        }
    }

}
