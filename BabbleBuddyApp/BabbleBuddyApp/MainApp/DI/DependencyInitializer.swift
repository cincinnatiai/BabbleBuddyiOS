import Foundation
import AuthLibrarySPM

class DependencyInitializer {
    static let container = Container()
    static let sharedAuthManager: AuthManager = AuthManager()
    static let sharedAuthViewModel: AuthViewModel = AuthViewModel(authManager: sharedAuthManager)
    static let sharedTokenHandler: TokenHandler = TokenHandler()
    
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
        container.register(TokenHandler.self) {
            DependencyInitializer.sharedTokenHandler
        }
        container.register(ViewLoaderViewModel.self) {
            ViewLoaderViewModel()
        }
        container.register(HomeScreen.self) {
            HomeScreen()
        }
        container.register(SettingsView.self) {
            SettingsView()
        }
        container.register(RemoteConfigProvider.self) {
            RemoteConfigProvider()
        }
    }
}
