//
//  BundleExtension.swift
//  BabyJournal
//
//  Created by Cincinnati Ai on 8/13/25.
//

import Foundation
import SettingsModule

final class BabyJournalModuleIdentifier {}

public struct BabyJournalLanguageConfig: LanguageConfigurableModule {
    public var moduleId: ModuleIdentifier = .babyJournalModule
    public var baseBundle: Bundle = Bundle(for: BabyJournalModuleIdentifier.self)
    public init() {}
}

extension Bundle {
    public static var babyJournalModule: Bundle {
        return bundle(for: .babyJournalModule, identifierType: BabyJournalModuleIdentifier.self)
    }
}
