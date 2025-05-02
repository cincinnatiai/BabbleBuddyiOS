import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

enum LocalizedStringKeys {
    static let HomeScreenLabel = "HomeScreen_Label".localized
    static let ViewLoaderLoadingLabel = "ViewLoader_Loading_Label".localized
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
