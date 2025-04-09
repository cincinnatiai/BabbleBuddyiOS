import Foundation
import UIKit
import AWSMobileClientXCF
@testable import SplashViewModule

class MockSplashViewModel: SplashViewModel {
    var shouldFail = false

    override func initializeAWSConfig() {
        if shouldFail {
            delegate?.showErrorScreen()
        } else {
            delegate?.navigateMainScreen(mainScreen: mainScreen())
        }
    }
}

class TestableSplashViewController: SplashViewController {
    var didNavigateToMainScreen = false
    var receivedMainVC: UIViewController?

    override func navigateMainScreen(mainScreen: UIViewController) {
        didNavigateToMainScreen = true
        receivedMainVC = mainScreen
    }
}
