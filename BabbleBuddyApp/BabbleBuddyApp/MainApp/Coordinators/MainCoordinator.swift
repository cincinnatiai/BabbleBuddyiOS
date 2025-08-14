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
import Combine
import SettingsModule

@MainActor
final class MainCoordinator: ObservableObject, BBCoordinator {
    // MARK: Private properties
    private let navigationController: UINavigationController
    private var splashViewCoordinator: SplashViewModuleCoordinator?
    private var authViewModel: AuthViewModel?
    private let tokenHandler = TokenHandler()
    private lazy var authManager = AuthManager(tokenProtocol: tokenHandler)
    private var cancellables: Set<AnyCancellable> = []

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
            authManager: authManager
        )
    }

    // MARK: Internal methods
    func createView() {
        let languageManager = LanguageManager.shared
        authManager.authStateSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] awsState in
                guard let self else { return }
                switch awsState {
                case .session:
                    Task { [weak self] in
                        guard let self else { return }
                        let ready = await self.waitForTokensReady()
                        if ready {
                            let view = TabBarView(tabsProvider: {
                                TabBarItemsProvider.items()
                            })
                            .environmentObject(languageManager)
                            self.navigateToSwiftUIView(view: view)
                        }
                    }
                case .login, .signUp, .confirmCode:
                    guard let authVM = self.authViewModel else { return }
                    let authScreen = AuthApp(
                        authManager: self.authManager,
                        authviewModel: authVM
                    ) { user in }
                    self.navigateToSwiftUIView(view: authScreen)
                }

            }
            .store(in: &cancellables)
    }

    // MARK: Private methods
    private func setupConfigurations() {
        let remoteConfigurationProvider = RemoteConfigProvider()

        Task {
            do {
                let baseUrl = try await remoteConfigurationProvider.fetchBaseUrl()
                KeychainHelper.shared.save(baseUrl, forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue)
                createView()
            } catch {
                // TODO: Pass this error to the error module
            }
        }
    }

    private func checkTokensAndCreateView() {
        Task {
            if await waitForTokensReady() {
                createView()
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
                    authManager
                )
                let host = UIHostingController(rootView: wrappedValueForAuthLibrary)
                navigationController.setNavigationBarHidden(true, animated: false)
                navigationController.setViewControllers([host], animated: animated)
            }
        }
    }

    private func waitForTokensReady() async -> Bool {
        await withCheckedContinuation { cont in
            authManager.tokensReadyPublisher
                .filter { $0 }
                .prefix(1)
                .receive(on: DispatchQueue.main)
                .sink { _ in cont.resume(returning: true) }
                .store(in: &cancellables)
        }
    }
}
