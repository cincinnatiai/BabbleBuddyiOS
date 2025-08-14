//
//  UserDefaultsService.swift
//  CoreKit
//
//  Created by Noel Hiram Pat Angulo on 7/30/25.
//

public final class UserDefaultsService: UserDefaultsServiceProtocol{
    public static let shared = UserDefaultsService()
    private let userDefaults: UserDefaults

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func set(value: Bool, key: String) {
        userDefaults.set(value, forKey: key)
    }

    public func set(value: String, key: String) {
        userDefaults.set(value, forKey: key)
    }

    public func getBool(key: String) -> Bool {
        userDefaults.bool(forKey: key)
    }

    public func getString(key: String) -> String? {
        userDefaults.string(forKey: key)
    }

    public func removeValue(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
