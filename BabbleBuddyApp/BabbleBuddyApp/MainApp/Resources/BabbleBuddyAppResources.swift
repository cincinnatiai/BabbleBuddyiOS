import Foundation

// MARK: - String Localization Extension

/// Provides a shorthand `.localized` property for any string,
/// resolving it via `NSLocalizedString`.
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

// MARK: - BabbleBuddy App Resources

/// Centralized static resources for shared app-level constants
enum BabbleBuddyAppResources {
    // MARK: Keychain Keys

    /// Keys used to access secure values in the Keychain.
    enum KeychainKeys: String {
        case idToken
        case baseURL
        case userName
    }
}
