import UIKit
import SwiftUI

class SplashViewController: UIViewController, SplashViewModelDelegate {

    private let splashViewModel: SplashViewModel = SplashViewModel()

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
        self.navigationController?.pushViewController(hostingController, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }

    func showErrorScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let alert = UIAlertController(
                title: NSLocalizedString("error_title", comment: "Title for error alert"),
                message: NSLocalizedString("error_message", comment: "Message for error alert"),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("error_button", comment: "Button title for error alert"),
                style: .default
            ))
            self.present(alert, animated: true)
        }
    }
}
