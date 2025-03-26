import Foundation

protocol SplashViewModelDelegate: AnyObject {
    func navigateMainScreen()
    func showErrorScreen()
}

class SplashViewModel {

    weak var delegate: SplashViewModelDelegate?

    func splashNavigation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.delegate?.navigateMainScreen()
        }
    }
}
