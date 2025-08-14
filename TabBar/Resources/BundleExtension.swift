//
//  BundleExtension.swift
//  TabBar
//
//  Created by Trainee on 4/3/25.
//

import Foundation
import SettingsModule

final class TabBarModuleIdentifier {}

public struct TabBarLanguageConfig: LanguageConfigurableModule {
    public var moduleId: ModuleIdentifier = .tabBarModule
    public var baseBundle: Bundle = Bundle(for: TabBarModuleIdentifier.self)
    public init() {}
}

extension Bundle {
    public static var tabBarModule: Bundle {
        return bundle(for: .tabBarModule, identifierType: TabBarModuleIdentifier.self)
    }
}
