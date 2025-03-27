import Foundation

class DependencyInitializer {
    static let container = Container()
    
    init() {
        addDependencies(to: DependencyInitializer.container)
    }
    
    func addDependencies (to container: Container) {

        // MARK: SplashView Dependencies
        container.register(SplashViewModel.self) {
            SplashViewModel()
        }
    }
}
