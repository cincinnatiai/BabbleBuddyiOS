import UIKit
import SwiftUI
import SplashViewModule

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainScreen = { UIHostingController(rootView: MainScreen()) }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        var splashViewModel = SplashViewModel(mainScreen: mainScreen)
        var splashViewController = SplashViewController(splashViewModel: splashViewModel)

        guard let windowScene = (scene as? UIWindowScene) else { return }
         _ = DependencyInitializer()

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
