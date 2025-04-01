// This screen will be deleted, it was created for testing the navigation from the splashview

import SwiftUI
import AuthLibrarySPM
import UIKit
import AWSMobileClientXCF
import DesignKit

struct MainScreen: View {

    @ObservedObject var authManager: AuthManager = {
        @Inject var globalAuthManager: AuthManager
        return globalAuthManager
    }()

    var body: some View {
        AuthApp(authManager: authManager) { _ in
            DesignKit.BabyRegistrationForm()
        }
        .environmentObject(authManager)
        .onAppear {
            resetAuthManager()
            authManager.initializeAWS()
            authManager.checkUserState()
        }
    }

    func resetAuthManager() {
        authManager.authState = .login
        authManager.isLoggedIn = false
        authManager.errorMessage = nil
        authManager.signOut()
    }
}
