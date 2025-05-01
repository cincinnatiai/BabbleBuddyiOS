import Foundation

final class SplashViewModuleIdentifier {}

extension Bundle {
    static var splashViewModule: Bundle {
        return Bundle(for: SplashViewModuleIdentifier.self)
    }
}
