//
//  KeychainStorageProtocol.swift
//  CoreKit
//
//  Created by Noel Hiram Pat Angulo on 6/13/25.
//

import Foundation

protocol KeychainStorable: AnyObject {
    @discardableResult
    func save(_ value: String, forKey: String) -> Bool

    func read(forKey key: String) -> String?

    @discardableResult
    func delete(forKey key: String) -> Bool

    @discardableResult
    func update(_ value: String, forKey key: String) -> Bool
}
