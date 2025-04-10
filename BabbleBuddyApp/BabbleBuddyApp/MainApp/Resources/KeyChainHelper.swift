//
//  KeyChainHelper.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 4/10/25.
//

import Foundation

class KeychainHelper {

    static let shared = KeychainHelper()
    private init() {}

    func save(_ value: String, forKey: String) {
        guard let data = value.data(using: .utf8) else { return }

        let query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : forKey,
            kSecValueData as String : data,
            kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    func read(forKey key: String ) -> String? {
        let query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String : kCFBooleanTrue!,
            kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        guard status == errSecSuccess , let data = dataTypeRef as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func deleteValues(forKey key: String) {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { return }
    }
}
