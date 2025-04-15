import Foundation
import SwiftUI
import TabBar
import BabiesList
import UIKit
import AuthLibrarySPM

struct MainScreen: View {
    
    @Inject var tokenHandler: TokenHandler
    private var keyChainKeys = KeychainKeys.self

    @StateObject var authManager: AuthManager = {
        @Inject var globalAuthManager: AuthManager
        return globalAuthManager
    }()
    
    @StateObject var authViewModel: AuthViewModel = {
        @Inject var globalAuthViewModel: AuthViewModel
        return globalAuthViewModel
    }()
    
    @StateObject var viewLoaderViewModel: ViewLoaderViewModel = {
       @Inject var viewLoaderViewModel: ViewLoaderViewModel
        return viewLoaderViewModel
    }()
    
    var body: some View {
        Group {
                AuthApp(authManager: authManager, authviewModel: authViewModel) { user in
                    if authViewModel.authState == .session(user: user) {
                        ViewLoader(viewModel: viewLoaderViewModel)
                    }
                }
                .environmentObject(authManager)
        }
        .onAppear {
            KeychainHelper.shared.deleteValues(forKey: keyChainKeys.idToken.rawValue)
            resetAuthManager()
            authManager.initializeAWS()
            authManager.checkUserState()
            authManager.setTokenProtocol(tokenHandler)
            tokenHandler.onTokenSaved = {
                viewLoaderViewModel.notifyTokenReady()
            }
            viewLoaderViewModel.fetchCognitoConfig()
        }
    }
    
    func resetAuthManager() {
        authViewModel.authState = .login
        authManager.isLoggedIn = false
        authViewModel.errorMessage = nil
        authManager.signOut()
    }
}
