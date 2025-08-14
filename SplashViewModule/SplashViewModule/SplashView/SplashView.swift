import UIKit
import SwiftUI
import Combine

public class SplashViewController: UIViewController {

    // MARK: Private propperties
    private let localizedStrings = String.LocalizeStringKeys.self
    private let appLogo: String
    private let onFinish: (() -> Void)
    private var didFire = false

    // MARK: Init
    public init(appLogo: String, onFinish: @escaping (() -> Void)) {
        self.appLogo = appLogo
        self.onFinish = onFinish
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUIView()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !didFire else { return }
        didFire = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.onFinish()
        }
    }

    // MARK: Private methods
    private func setUIView() {
        let logoImageView = UIImageView(image: UIImage(named: appLogo))

        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: UIConstants.widthAnchorConstant),
            logoImageView.heightAnchor.constraint(equalToConstant: UIConstants.heightAnchorConstant)
        ])
    }
}
