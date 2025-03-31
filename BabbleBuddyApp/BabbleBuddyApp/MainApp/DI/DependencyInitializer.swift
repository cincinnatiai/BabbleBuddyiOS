import Foundation
import AuthLibrarySPM

class DependencyInitializer {
    static let container = Container()
    static let sharedAuthManager: AuthManager = {
        return MainActor.assumeIsolated { AuthManager() }
        }()
    init() {
        addDependencies(to: DependencyInitializer.container)
    }
    
    func addDependencies (to container: Container) {

        // MARK: SplashView Dependencies
        container.register(SplashViewModel.self) {
            SplashViewModel()
        }

        // MARK: AuthManager Singleton
        container.register(AuthManager.self) {
           DependencyInitializer.sharedAuthManager
        }
    }
}
