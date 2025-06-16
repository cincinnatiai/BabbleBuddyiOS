import Foundation
import CoreKit

final class TokenProviderService {
    static let token: () -> String = {
        KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue) ?? ""
    }
}
