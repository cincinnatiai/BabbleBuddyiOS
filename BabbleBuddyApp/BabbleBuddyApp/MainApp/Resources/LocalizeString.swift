import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

enum LocalizedStringKeys {
    static let HomeScreenLabel = "HomeScreen_Label".localized
}
