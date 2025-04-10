import Foundation
import AuthLibrarySPM

class DependencyInitializer {
    static let container = Container()
    static let sharedAuthManager: AuthManager = AuthManager()
    static let sharedAuthViewModel: AuthViewModel = AuthViewModel(authManager: sharedAuthManager)
    static let sharedTokenHandler: TokenHandler = {
            return TokenHandler()
        }()
    
    init() {
        addDependencies(to: DependencyInitializer.container)
    }
    
    func addDependencies (to container: Container) {
        
        // MARK: AuthManager Singleton
        container.register(AuthManager.self) {
           DependencyInitializer.sharedAuthManager
        }
        
        container.register(AuthViewModel.self) {
            DependencyInitializer.sharedAuthViewModel
        }
        
        
        container.register(TokenHandler.self) {
            DependencyInitializer.sharedTokenHandler
        }

        // MARK: SplashView Dependencies
        container.register(SplashViewModel.self) {
            SplashViewModel()
        }
    }
}
