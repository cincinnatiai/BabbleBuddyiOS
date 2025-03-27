import UIKit
import SwiftUI

class SplashViewController: UIViewController, SplashViewModelDelegate {

    private let splashViewModel: SplashViewModel = SplashViewModel()
    private let localizedStrings = String.LocalizeStringKeys.self

    override func viewDidLoad() {
        super.viewDidLoad()

        setUIView()
        splashViewModel.delegate = self
        splashViewModel.splashNavigation()
    }

    func setUIView() {
        let logoImageView = UIImageView(image: UIImage(named: "BabbleBuddyLogo"))

        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func navigateMainScreen() {
        let hostingController = UIHostingController(rootView: MainScreen())
        self.navigationController?.setViewControllers([hostingController], animated: true)
    }

    func showErrorScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let alert = UIAlertController(
                title: self.localizedStrings.SplashViewErrorTitle,
                message: self.localizedStrings.SplashViewErrorMessage,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: self.localizedStrings.SplashViewErrorButton,
                style: .default
            ))
            self.present(alert, animated: true)
        }
    }
}
