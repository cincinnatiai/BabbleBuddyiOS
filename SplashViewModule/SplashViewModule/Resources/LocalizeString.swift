import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

//    var localized: String {
//        let bundle = Bundle.module
//        return  NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: self, comment: "")
//    }

    enum LocalizeStringKeys {
        static let SplashViewErrorTitle = "SplashView_error_title".localized
        static let SplashViewErrorMessage = "SplashView_error_message".localized
        static let SplashViewErrorButton = "SplashView_error_button".localized
    }
}
