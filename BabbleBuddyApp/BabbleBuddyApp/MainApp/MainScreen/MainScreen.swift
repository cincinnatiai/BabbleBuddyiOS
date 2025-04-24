import Foundation
import SwiftUI
import TabBar
import BabiesList
import UIKit
import AuthLibrarySPM

struct MainScreen: View {
    
    @StateObject var authManager: AuthManager = {
        @Inject var globalAuthManager: AuthManager
        return globalAuthManager
    }()
    
    @StateObject var authViewModel: AuthViewModel = {
        @Inject var globalAuthViewModel: AuthViewModel
        return globalAuthViewModel
    }()

    var body: some View {
        AuthApp(authManager: authManager, authviewModel: authViewModel) { _ in
            HomeScreen()
        }
        .environmentObject(authManager)
        .onAppear {
            resetAuthManager()
            authManager.initializeAWS()
            authManager.checkUserState()
        }
    }

    func resetAuthManager() {
        authViewModel.authState = .login
        authManager.isLoggedIn = false
        authViewModel.errorMessage = nil
        authManager.signOut()
    }
}
