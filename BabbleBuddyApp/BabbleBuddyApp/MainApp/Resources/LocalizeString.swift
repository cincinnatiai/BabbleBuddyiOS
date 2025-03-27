import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    enum LocalizeStringKeys {
        static let SplashViewErrorTitle = "SplashView_error_title".localized
        static let SplashViewErrorMessage = "SplashView_error_message".localized
        static let SplashViewErrorButton = "SplashView_error_button".localized
    }
}
