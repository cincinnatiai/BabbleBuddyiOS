import Foundation

final class TokenProviderService {
    static let token: () -> String = {
        KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue) ?? ""
    }

    static let baseURL: () -> String = {
        KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue) ?? ""
    }
}
