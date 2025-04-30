import Foundation
import AuthLibrarySPM

class DependencyInitializer {
    static let container = Container()
    static let sharedAuthManager: AuthManager = AuthManager()
    static let sharedAuthViewModel: AuthViewModel = AuthViewModel(authManager: sharedAuthManager)
    
    init() {
        addDependencies(to: DependencyInitializer.container)
    }
    
    func addDependencies (to container: Container) {
        container.register(AuthManager.self) {
            DependencyInitializer.sharedAuthManager
        }
        container.register(AuthViewModel.self) {
            DependencyInitializer.sharedAuthViewModel
        }
    }
}
