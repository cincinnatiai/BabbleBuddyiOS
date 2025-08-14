//
//  BundleExtension.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation
import SettingsModule

final class BabiesListModuleIdentifier {}

public struct BabiesListLanguageConfig: LanguageConfigurableModule {
    public var moduleId: ModuleIdentifier = .babiesListModule
    public var baseBundle: Bundle = Bundle(for: BabiesListModuleIdentifier.self)
    public init() {}
}

extension Bundle {
    public static var babiesListModule: Bundle {
        return bundle(for: .babiesListModule, identifierType: BabiesListModuleIdentifier.self)
    }
}
