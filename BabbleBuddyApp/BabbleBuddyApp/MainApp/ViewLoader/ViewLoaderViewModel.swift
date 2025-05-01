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
    
    func setViewControllers() {
        let controllers: [String: UIViewController] = [
            BabbleBuddyAppResources.TabBarViewControllerKeys.home.rawValue: UIHostingController(rootView: homeScreen),
            BabbleBuddyAppResources.TabBarViewControllerKeys.settings.rawValue: UIHostingController(rootView: settingsView)
        ]
        self.viewControllers = controllers
        self.isReady = true
    }
}
