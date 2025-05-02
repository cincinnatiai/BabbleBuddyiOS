import Foundation
import SwiftUI
import TabBar
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
    
    @StateObject var viewLoaderViewModel: ViewLoaderViewModel = {
       @Inject var viewLoaderViewModel: ViewLoaderViewModel
        return viewLoaderViewModel
    }()
    
    @Inject var tokenHandler: TokenHandler
    
    var body: some View {
        Group {
            AuthApp(authManager: authManager, authviewModel: authViewModel) { user in
                if authViewModel.authState == .session(user: user) {
                    ViewLoader(viewModel: viewLoaderViewModel)
                        .onAppear {
                            tokenHandler.onTokenSaved = {
                                viewLoaderViewModel.notifyTokenReady()
                            }
                        }
                }
            }
            .environmentObject(authManager)
        }
        .onAppear {
            KeychainHelper.shared.deleteValues(forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue)
            resetAuthManager()
            authManager.initializeAWS()
            authManager.checkUserState()
            authManager.setTokenProtocol(tokenHandler)
            viewLoaderViewModel.fetchRemoteConfig()
        }
    }

    func resetAuthManager() {
        authViewModel.authState = .login
        authManager.isLoggedIn = false
        authViewModel.errorMessage = nil
        authManager.signOut()
    }
}
