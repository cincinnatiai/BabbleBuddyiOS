// This screen will be deleted, it was created for testing the navigation from the splashview

import SwiftUI
import AuthLibrarySPM
import UIKit
import AWSMobileClientXCF
import DesignKit

public struct MainScreen: View {

    @StateObject public var authManager: AuthManager = {
        @Inject var globalAuthManager: AuthManager
        return globalAuthManager
    }()

    public var body: some View {
        AuthApp(authManager: authManager) { _ in
            DesignKit.BabyRegistrationForm()
        }
        .environmentObject(authManager)
        .onAppear {
            resetAuthManager()
            authManager.checkUserState()
        }
    }

   public func resetAuthManager() {
        authManager.authState = .login
        authManager.isLoggedIn = false
        authManager.errorMessage = nil
        authManager.signOut()
    }
}
