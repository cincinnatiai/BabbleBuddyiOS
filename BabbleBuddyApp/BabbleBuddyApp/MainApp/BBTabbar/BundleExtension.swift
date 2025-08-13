//
//  BundleExtension.swift
//  BabbleBuddyApp
//
//  Created by Cincinnati Ai on 8/13/25.
//

import Foundation
import SettingsModule

final class BabbleBuddyModuleIdentifier {}

public struct BabbleBuddyLanguageConfig: LanguageConfigurableModule {
    public var moduleId: ModuleIdentifier = .babbleBuddyModule
    public var baseBundle: Bundle = Bundle(for: BabbleBuddyModuleIdentifier.self)
    public init() {}
}

extension Bundle {
    public static var babbleBuddyModule: Bundle {
        return bundle(for: .babbleBuddyModule, identifierType: BabbleBuddyModuleIdentifier.self)
    }
}
