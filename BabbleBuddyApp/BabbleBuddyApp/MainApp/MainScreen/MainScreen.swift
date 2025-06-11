import SwiftUI
import TabBar
import AuthLibrarySPM

struct MainScreenV2: View {

    @StateObject var authManager: AuthManager = {
        @Inject var globalAuthManager: AuthManager
        return globalAuthManager
    }()

    @StateObject var authViewModel: AuthViewModel = {
        @Inject var globalAuthViewModel: AuthViewModel
        return globalAuthViewModel
    }()

    @Inject var tokenHandler: TokenHandler
    @Inject var configurationService: ConfigurationService

    @State private var didFetchURL = false

    var body: some View {
        Group {
            AuthApp(authManager: authManager, authviewModel: authViewModel) { user in
                if authViewModel.authState == .session(user: user) {
                    TabBarViewV2(tabs: TabBarItemsProvider.items())
                }
            }
            .environmentObject(authManager)
        }
        .onAppear {
            initializeApp()
        }
    }

    private func initializeApp() {
        guard !didFetchURL else { return }
        didFetchURL = true

        configurationService.fetchBaseURL { _ in }
        authManager.setTokenProtocol(tokenHandler)
        authManager.initializeAWS()
        authManager.checkUserState()
        resetAuthManager()
    }

    private func resetAuthManager() {
        authViewModel.authState = .login
        authManager.isLoggedIn = false
        authViewModel.errorMessage = nil
        authManager.signOut()
    }
}
