import Foundation
import AuthLibrarySPM

// MARK: - DependencyInitializer

/// A centralized dependency registration hub using `Container`.
/// This setup allows for shared instances to be injected across modules.
/// Currently, this might be unused in runtime if a different DI entry point is used.
class DependencyInitializer {

    // MARK: - Static Shared Instances

    /// The shared dependency container instance.
    static let container = Container()

    /// Shared instances for Auth-related services.
    static let sharedAuthManager: AuthManager = AuthManager()
    static let sharedAuthViewModel: AuthViewModel = AuthViewModel(authManager: sharedAuthManager)
    static let sharedTokenHandler: TokenHandler = TokenHandler()

    // MARK: - Initialization

    /// Initializes and registers all dependencies into the container.
    init() {
        addDependencies(to: DependencyInitializer.container)
    }

    // MARK: - Dependency Registration

    /// Registers all services and view models into the provided container.
    func addDependencies(to container: Container) {
        container.register(AuthManager.self) {
            DependencyInitializer.sharedAuthManager
        }

        container.register(AuthViewModel.self) {
            DependencyInitializer.sharedAuthViewModel
        }

        container.register(TokenHandler.self) {
            DependencyInitializer.sharedTokenHandler
        }
    }
}
