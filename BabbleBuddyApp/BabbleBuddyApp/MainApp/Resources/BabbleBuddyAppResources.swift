import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

enum BabbleBuddyAppResources {
    enum TabBarViewControllerKeys: String {
        case home
        case settings
    }
    
    enum KeychainKeys: String {
        case idToken
        case baseURL
    }
}
