import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .splashViewModule, comment: "")
    }

    enum LocalizeStringKeys {
        static var SplashViewErrorTitle: String { "SplashView_error_title".localized }
        static var SplashViewErrorMessage: String { "SplashView_error_message".localized }
        static var SplashViewErrorButton: String { "SplashView_error_button".localized }
    }
}
