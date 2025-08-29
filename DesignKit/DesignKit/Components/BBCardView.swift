import SwiftUI

/// A card view used to display baby or event-related information in a stylized container.
public struct BBCardView: View {
    // MARK: - Properties

    let name: String
    let imageURL: String
    let description: String
    let onTap: (() -> Void)?
    let type: BabyCardType
    let onEdit: (() -> Void)?
    let onDelete: (() -> Void)?

    public init(
        name: String,
        description: String,
        imageURL: String? = nil,
        type: BabyCardType,
        onEdit: @escaping (() -> Void),
        onDelete: @escaping (()-> Void),
        onTap: (() -> Void)? = nil)
        
    {
        self.name = name
        self.description = description
        self.imageURL = imageURL ?? ""
        self.onTap = onTap
        self.type = type
        self.onEdit = onEdit
        self.onDelete = onDelete
    }

    public var body: some View {
        BBCardSectionViewContainer(
            title: name,
            icon: iconView,
            editIcon: AnyView(
                Button(action: { onEdit?() }) {
                    Image(systemName: "pencil")
                        .font(.title2)
                }
                    .buttonStyle(.plain)
            ), deleteIcon: AnyView(
                Button(action: { onDelete?() }) {
                    Image(systemName: "trash.fill")
                        .font(.title2)
                }
                    .buttonStyle(.plain)
            ),
            onTap: onTap) {
            }
    }
    // MARK: - Icon View

    private var iconView: Image? {
        switch type {
        case .baby(let gender):
            if let url = URL(string: imageURL),
               let data = try? Data(contentsOf: url),
               let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
            return Image(systemName: gender == "female" ? "figure.stand.dress" : "figure.stand")
        case .event(let eventType):
            return Image(eventIcon(for: eventType))
        }
    }

    private func eventIcon(for type: EventType) -> String {
        switch type {
        case .eat: return "feeding-bottle"
        case .pee: return "pee-icon"
        case .poop: return "poop-icon"
        case .sleep: return "sleeping-icon"
        case .sleep_start: return "sleeping-icon"
        case .sleep_end: return "sleeping-icon"
        case .play: return "play-icon"
        case .weight: return "wheight-icon"
        case .height: return "height-icon"
        case .head_circumference: return "head-size"
        case .more: return "ellipsis.circle"
        case .less: return "chevron.up.circle"
        }
    }

}

// MARK: - Enum Definitions

public enum BabyCardType {
    case baby(gender: String?)
    case event(EventType)
}

public enum EventType: String, CaseIterable {
    case eat, pee, poop, sleep, sleep_start, sleep_end, play
    case weight, height, head_circumference
    case more, less

    static var primary: [EventType] {
        [.eat, .pee, .poop, .sleep, .play, .more]
    }

    static var secondary: [EventType] {
        [.weight, .height, .head_circumference, .less]
    }

    public var eventName: String {
           switch self {
           case .eat:
               return "EAT"
           default:
               return self.rawValue.uppercased()
           }
       }
}
