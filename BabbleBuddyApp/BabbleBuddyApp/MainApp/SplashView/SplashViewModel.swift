import Foundation
import AWSMobileClientXCF

protocol SplashViewModelDelegate: AnyObject {
    func navigateMainScreen()
    func showErrorScreen()
}

class SplashViewModel {
    weak var delegate: SplashViewModelDelegate?

    func initializeAWSConfig() {
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
                        self.delegate?.navigateMainScreen()
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
