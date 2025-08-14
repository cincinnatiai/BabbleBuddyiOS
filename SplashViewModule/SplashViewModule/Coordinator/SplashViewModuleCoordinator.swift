//
//  SplashViewModuleCoordinator.swift
//  SplashViewModule
//
//  Created by Noel Hiram Pat Angulo on 8/8/25.
//

import DesignKit
import UIKit

public final class SplashViewModuleCoordinator: BBCoordinator {
    // MARK: Private propperties
    private let navigationController: UINavigationController
    private let appLogo: String
    private let transitionEnds: () -> Void
    private var splashViewController: SplashViewController?

    // MARK: Init
    public init(
        navigationController: UINavigationController, appLogo: String, transitionEnds: @escaping () -> Void) {
            self.navigationController = navigationController
            self.appLogo = appLogo
            self.transitionEnds = transitionEnds
        }
    
    public func start() {
        splashViewController = SplashViewController(appLogo: appLogo) { [weak self] in
            self?.transitionEnds()
        }
        createView()
    }

    public func createView() {
        guard let splashViewController else { return }
        navigationController
            .pushViewController(splashViewController, animated: true)
    }
}
