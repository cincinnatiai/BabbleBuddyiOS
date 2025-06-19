import SwiftUI

public struct BBCardView: View {
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

// MARK: Cases for type of card that can be displayed
public enum BabyCardType {
    case baby(gender: String?)
    case event(EventType)
}

public enum EventType: String {
    case feed, pee, poop, sleep, play, weight, height, headSize
}
