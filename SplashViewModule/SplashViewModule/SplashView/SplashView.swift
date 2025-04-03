import UIKit
import SwiftUI

public class SplashViewController: UIViewController, SplashViewModelDelegate {

    private let splashViewModel: SplashViewModel
    private let localizedStrings = String.LocalizeStringKeys.self

    public init(splashViewModel: SplashViewModel) {
        self.splashViewModel = splashViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setUIView()
        splashViewModel.delegate = self
        splashViewModel.initializeAWSConfig()
    }

    public func setUIView() {
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

    public func navigateMainScreen(mainScreen: UIViewController) {
        self.navigationController?.setViewControllers([mainScreen], animated: true)
    }

   public func showErrorScreen() {
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
