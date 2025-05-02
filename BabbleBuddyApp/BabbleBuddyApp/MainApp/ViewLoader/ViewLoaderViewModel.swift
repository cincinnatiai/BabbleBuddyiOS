//
//  ViewLoaderViewModel.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 5/1/25.
//

import Foundation
import TabBar
import UIKit
import AuthLibrarySPM
import SwiftUI

class ViewLoaderViewModel: ObservableObject {
    @Published var isReady: Bool = false
    @Published var viewControllers: [String: UIViewController] = [:]
    @Inject var homeScreen: HomeScreen
    @Inject var settingsView: SettingsView
    
    private var tokenAvailable = false
    private var baseURLAvailable = false
    private let fireBaseService: FirebaseService = {
        @Inject var fireBaseService: FirebaseService
        return fireBaseService
    }()
    
    func notifyTokenReady() {
        tokenAvailable = true
        tryInitialization()
    }
    
    private func tryInitialization() {
        guard tokenAvailable, baseURLAvailable else { return }
        initializeData()
    }
    
    func initializeData() {
        guard let _ = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue),
              let _ = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue)
        else { return }
        setViewControllers()
    }
    
    func setViewControllers() {
        let controllers: [String: UIViewController] = [
            BabbleBuddyAppResources.TabBarViewControllerKeys.home.rawValue: UIHostingController(rootView: homeScreen),
            BabbleBuddyAppResources.TabBarViewControllerKeys.settings.rawValue: UIHostingController(rootView: settingsView)
        ]
        self.viewControllers = controllers
        self.isReady = true
    }
    
    func fetchCognitoConfig() {
        fireBaseService.fetchURLs { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let config):
                guard let url = config.values.first  as? String else { return }
                KeychainHelper.shared.save(url,forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue)
                baseURLAvailable = true
                tryInitialization()
            case .failure: break
            }
        }
    }
}
