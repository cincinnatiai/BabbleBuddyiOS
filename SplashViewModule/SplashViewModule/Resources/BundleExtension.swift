import Foundation
import SettingsModule

final class SplashViewModuleIdentifier {}

public struct SplashViewLanguageConfig: LanguageConfigurableModule {
    public var moduleId: ModuleIdentifier = .splashViewModule
    public var baseBundle: Bundle = Bundle(for: SplashViewModuleIdentifier.self)
    public init() {}
}

extension Bundle {
    public static var splashViewModule: Bundle {
        return bundle(for: .splashViewModule, identifierType: SplashViewModuleIdentifier.self)
    }
}
