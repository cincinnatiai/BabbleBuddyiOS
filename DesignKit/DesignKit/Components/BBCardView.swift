import SwiftUI

/// A card view used to display baby or event-related information in a stylized container.
public struct BBCardView: View {
    // MARK: - Properties

    let name: String
    let imageURL: String
    let description: String
    let type: BabyCardType

    public init(name: String, description: String, imageURL: String? = nil, type: BabyCardType) {
        self.name = name
        self.description = description
        self.imageURL = imageURL ?? ""
        self.type = type
    }

    public var body: some View {
        BBCardSectionViewContainer(title: name, icon: iconView) {
            Text(description)
                .textStyle(.body)
                .foregroundColor(AppColor.textSecondary)
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
            return Image(systemName: eventIcon(for: eventType))
        }
    }

    // MARK: - Helpers

    private func eventIcon(for type: EventType) -> String {
        switch type {
        case .feed: return "fork.knife.circle"
        case .pee: return "drop.fill"
        case .poop: return "leaf.fill"
        case .sleep: return "bed.double.fill"
        case .play: return "gamecontroller.fill"
        case .weight: return "scalemass.fill"
        case .height: return "arrow.up.and.down"
        case .headSize: return "person.crop.square"
        }
    }
}

// MARK: - Enum Definitions

public enum BabyCardType {
    case baby(gender: String?)
    case event(EventType)
}

public enum EventType: String, CaseIterable {
    case feed, pee, poop, sleep, play, weight, height, headSize
}
