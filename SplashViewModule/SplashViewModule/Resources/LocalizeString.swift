import Foundation

extension String {
    public var localized: String {
        NSLocalizedString(self, comment: "")
    }

    public enum LocalizeStringKeys {
        public static let SplashViewErrorTitle = "SplashView_error_title".localized
        public static let SplashViewErrorMessage = "SplashView_error_message".localized
        public static let SplashViewErrorButton = "SplashView_error_button".localized
    }
}
