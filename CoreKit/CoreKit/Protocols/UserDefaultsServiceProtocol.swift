//
//  UserDefaultsServiceProtocol.swift
//  CoreKit
//
//  Created by Noel Hiram Pat Angulo on 7/30/25.
//

public protocol UserDefaultsServiceProtocol {
    func set(value: Bool, key: String)
    func getBool(key: String) -> Bool
    func set(value: String, key: String)
    func getString(key: String) -> String?
    func removeValue(key: String)
}

