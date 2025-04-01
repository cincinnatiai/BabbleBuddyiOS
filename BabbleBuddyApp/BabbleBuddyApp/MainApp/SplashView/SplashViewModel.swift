import Foundation
import AWSMobileClientXCF
import os.log

protocol SplashViewModelDelegate: AnyObject {
    func navigateMainScreen()
    func showErrorScreen()
}

class SplashViewModel {
    weak var delegate: SplashViewModelDelegate?

    func initializeAWS() {
        do {
            let configURL = try AWSConfigManager.shared.createAWSConfigurationFile()
            let jsonData = try Data(contentsOf: configURL)

            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                AWSInfo.configureDefaultAWSInfo(jsonDict)
            }
            AWSMobileClient.default().initialize { (_, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        os_log("Error initializing AWS: %@", type: .error, error.localizedDescription)
                        self.delegate?.showErrorScreen()
                    } else {
                        os_log("AWS Initialized successfully", type: .info)
                        self.delegate?.navigateMainScreen()
                    }
                }
            }
        } catch {
            os_log("Error reading AWS config: %@", type: .error, error.localizedDescription)
            DispatchQueue.main.async {
                self.delegate?.showErrorScreen()
            }
        }
    }
}
