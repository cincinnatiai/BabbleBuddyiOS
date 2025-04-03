import Foundation
import AWSMobileClientXCF

public protocol SplashViewModelDelegate: AnyObject {
    func navigateMainScreen(mainScreen: UIViewController)
    func showErrorScreen()
}

public class SplashViewModel {

    public weak var delegate: SplashViewModelDelegate?
    private let mainScreen: () -> UIViewController

    public init(mainScreen: @escaping () -> UIViewController) {
        self.mainScreen = mainScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public func initializeAWSConfig() {
        do {
            let configURL = try AWSConfigManager.shared.createAWSConfigurationFile()
            let jsonData = try Data(contentsOf: configURL)

            if let jsonFile = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                AWSInfo.configureDefaultAWSInfo(jsonFile)
            }

            AWSMobileClient.default().initialize { [weak self] (_, error) in
                DispatchQueue.main.async {
                    guard let self = self else {return}

                    if error != nil {
                        self.delegate?.showErrorScreen()
                    } else {
                        self.delegate?.navigateMainScreen(mainScreen: self.mainScreen())
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.delegate?.showErrorScreen()
            }
        }
    }
}
