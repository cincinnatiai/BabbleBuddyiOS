//
//  BundleExtension.swift
//  SettingsModule
//
//  Created by Cincinnati Ai on 8/8/25.
//

import Foundation

public enum ModuleIdentifier {
    case babiesListModule
    case splashViewModule
    case tabBarModule
    case settingsModule
}

private var bundleOverrides: [ModuleIdentifier: Bundle] = [:]

public extension Bundle {
    static func setLanguage(bundle: Bundle, for module: ModuleIdentifier) {
        bundleOverrides[module] = bundle
    }
    
    static func bundle(for module: ModuleIdentifier, identifierType: AnyClass) -> Bundle {
        if let overrideBundle = bundleOverrides[module] {
            return overrideBundle
        } else {
            return Bundle(for: identifierType)
        }
    }
}

final class SettingsModuleIndentifier {}

public struct SettingsLanguageConfig: LanguageConfigurableModule {
    public var moduleId: ModuleIdentifier = .settingsModule
    public var baseBundle: Bundle = Bundle(for: SettingsModuleIndentifier.self)
    public init() {}
}

extension Bundle {
    public static var settingsModule: Bundle {
        return bundle(for: .settingsModule, identifierType: SettingsModuleIndentifier.self)
    }
}
