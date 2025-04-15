//
//  ViewLoaderViewModel.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 4/15/25.
//

import Foundation
import TabBar
import BabiesList
import NetworkingKit
import UIKit
import AuthLibrarySPM
import SwiftUI

class ViewLoaderViewModel: ObservableObject {
    @Published var listViewModel: BabyListViewModel?
    @Published var listView: BabyListView?
    @Published var isReady: Bool = false
    @Published var viewControllers: [String: UIViewController] = [:]
    
    private var tokenAvailable = false
    private var baseURLAvailable = false
    
    private var babiesResponse: Result<[AccountResponseModel], Error>?
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
        guard let id = KeychainHelper.shared.readValue(for: .idToken),
              let url = KeychainHelper.shared.readValue(for: .baseURL)
        else { return }
        
        let call = BabiesListServiceImpl(dataProvider: { (url, id) })
        
        Task {
            let response = await call.fetchBabies()
            await MainActor.run {
                self.babiesResponse = response
                self.setBabiesList()
                self.setViewControllers()
            }
        }
    }
    
    func setBabiesList() {
        guard let babiesResponse else { return }
        listViewModel = BabyListViewModel(infoProvider: { babiesResponse })
        if let listVM = listViewModel {
            listView = BabyListView(viewModel: listVM)
        }
    }
    
    func setViewControllers() {
        var controllers: [String: UIViewController] = [
            TabBarViewControllerKeys.home.rawValue: UIHostingController(rootView: HomeScreen()),
            TabBarViewControllerKeys.settings.rawValue: UIHostingController(rootView: SettingsView())
        ]
        guard let listView else { return }
        controllers[TabBarViewControllerKeys.babies.rawValue] = listView
        
        self.viewControllers = controllers
        self.isReady = true
    }
    
    func fetchCognitoConfig() {
        fireBaseService.fetchURLs { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let config):
                guard let url = config.values.first  as? String else { return }
                KeychainHelper.shared.saveValue(url, for: .baseURL)
                baseURLAvailable = true
                tryInitialization()
            case .failure: break
                
            }
        }
    }
}
