import UIKit
import SplashViewModule
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        _ = DependencyInitializer()
        // TODO: Create the App coordinator
        let mainScreen = { UIHostingController(rootView: MainScreen()) }
        let splashViewModel = SplashViewModel(mainScreen: mainScreen)
        let splashViewController = SplashViewController(splashViewModel: splashViewModel)
        let navigationController = UINavigationController(rootViewController: splashViewController)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
}

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}
