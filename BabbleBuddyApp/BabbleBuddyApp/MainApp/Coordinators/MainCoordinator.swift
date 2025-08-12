//
//  MainCoordinator.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 8/8/25.
//

import DesignKit
import AuthLibrarySPM
import CoreKit
import SwiftUI
import TabBar
import AWSMobileClientXCF
import SplashViewModule

final class MainCoordinator: ObservableObject, BBCoordinator {
    // MARK: Private properties
    private var authManager: AuthManager?
    private let navigationController: UINavigationController
    private var splashViewCoordinator: SplashViewModuleCoordinator?
    private var authViewModel: AuthViewModel?
    private let tokenHandler = TokenHandler()

    // MARK: Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        initializeAWSConfig()
        splashViewCoordinator = SplashViewModuleCoordinator(
            navigationController: navigationController,
            appLogo: "BabbleBuddyLogo"
        ) { [weak self] in
            self?.setupConfigurations()
        }
        splashViewCoordinator?.start()
        authViewModel = AuthViewModel(
            authManager: getAuthManager()
        )
    }

    // MARK: Internal methods
    func createView() {
        AWSMobileClient.default().initialize { [weak self] (state, error) in
            guard let self else { return }
            Task {
                await MainActor.run {
                    switch state {
                    case .signedIn:
                        self.authManager?.isLoggedIn = true
                        self.navigateToSwiftUIView(view: TabBarView(tabs: TabBarItemsProvider.items()))
                    default:
                        guard let authViewModel = self.authViewModel else {
                            return
                        }
                        let authScreen =  AuthApp(
                            authManager: self.getAuthManager(),
                            authviewModel: authViewModel
                        ) { user in
                            if authViewModel.authState ==
                                .session(user: user) {
                                TabBarView(tabs: TabBarItemsProvider.items())
                            }
                        }
                        self.navigateToSwiftUIView(view: authScreen)
                    }
                }
            }
            if error != nil {
                // TODO: Pass this error to the error module
            }
        }
    }

    // MARK: Private methods
    private func setupConfigurations() {
        let remoteConfigurationProvider = RemoteConfigProvider()

        Task {
            do {
                let baseUrl = try await remoteConfigurationProvider.fetchBaseUrl()
                KeychainHelper.shared.save(baseUrl, forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue)
                authManager?.initializeAWS()
                authManager?.checkUserState()
                createView()
            } catch {
                // TODO: Pass this error to the error module
            }
        }
    }

    private func initializeAWSConfig() {
        do {
            let configURL = try AWSConfigManager.shared.createAWSConfigurationFile()
            let jsonData = try Data(contentsOf: configURL)

            if let jsonFile = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                AWSInfo.configureDefaultAWSInfo(jsonFile)
            }
        } catch {
            // TODO: Pass this error to the error module
        }
    }

    private func navigateToSwiftUIView(view: some View, animated: Bool = true) {
        Task {
            await MainActor.run {
                /// This wrapp is needed due to the settings view of the auth library,
                /// we need to get rid of that view and build our own that call the sign out from the library
                let wrappedValueForAuthLibrary = view.environmentObject(
                    getAuthManager()
                )
                let host = UIHostingController(rootView: wrappedValueForAuthLibrary)
                navigationController.setNavigationBarHidden(true, animated: false)
                navigationController.setViewControllers([host], animated: animated)
            }
        }
    }

    private func getAuthManager() -> AuthManager {
        let authMngr = AuthManager(tokenProtocol: self.tokenHandler)
        self.authManager = authMngr
        return authMngr
    }
}
