import Foundation
import AuthLibrarySPM
import Security
import CoreKit

public class TokenHandler: TokenManagerProtocol {

    private enum KeychainKeys {
        public static let idToken = "idToken"
        public static let refreshToken = "refreshToken"
        public static let accessToken = "accessToken"
    }

    public init() {}

    // MARK: Handle IDTokens on Keychain Values
    public func getIdToken() -> String? {
        return KeychainHelper.shared.read(forKey: KeychainKeys.idToken)
    }

    public func manageTokenId(idToken: String) {
        KeychainHelper.shared.save(idToken, forKey: KeychainKeys.idToken)
    }

    // MARK: Handle Refresh on Keychain Values
    public func getRefreshToken() -> String? {
        return KeychainHelper.shared.read(forKey: KeychainKeys.refreshToken)
    }

    public func manageRefreshToken(refreshToken: String) {
        KeychainHelper.shared.save(refreshToken, forKey: KeychainKeys.refreshToken)
    }

    // MARK: Handle Access Tokens on Keychain Values
    public func getAccessToken() -> String? {
        return KeychainHelper.shared.read(forKey: KeychainKeys.accessToken)
    }

    public func manageAccessToken(accessToken: String) {
        KeychainHelper.shared.save(accessToken, forKey: KeychainKeys.accessToken)
    }

    // MARK: Handle New Tokens on Keychain Values
    public func getNewTokens() -> (idToken: String?, accessToken: String?) {
        let idToken = KeychainHelper.shared.read(forKey: KeychainKeys.idToken)
        let accessToken = KeychainHelper.shared.read(forKey: KeychainKeys.accessToken)
        return (idToken, accessToken)
    }

    public func manageNewTokens(idToken: String, accessToken: String) {
        KeychainHelper.shared.save(idToken, forKey: KeychainKeys.idToken)
        KeychainHelper.shared.save(accessToken, forKey: KeychainKeys.accessToken)
    }

    // MARK: Clear tokens stored
    public func clearAllTokens() {
        KeychainHelper.shared.delete(forKey: KeychainKeys.idToken)
        KeychainHelper.shared.delete(forKey: KeychainKeys.accessToken)
        KeychainHelper.shared.delete(forKey: KeychainKeys.refreshToken)
    }
}
