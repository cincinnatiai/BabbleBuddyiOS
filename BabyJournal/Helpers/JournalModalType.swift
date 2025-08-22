import Foundation

enum JournalModalType: Identifiable {
    case bottomSheet
    case eventDetail(event: BabyEventDisplayableInfo)

    var id: String {
        switch self {
        case .bottomSheet:
            return "bottomSheet"
        case .eventDetail(let event):
            return "eventDetail_\(event.eventType)_\(event.eventDate)"
        }
    }
}
