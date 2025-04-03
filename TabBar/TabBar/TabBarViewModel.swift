//
//  TabBarViewModel.swift
//  TabBar
//
//  Created by Trainee on 4/1/25.
//

import Foundation
import Combine
import UIKit
import SwiftUI

public class TabBarViewModel: ObservableObject {
    @Published var screensState: ScreensState = .loading
    private let viewControllersProvider: () -> [String : UIViewController]
    private let localizedStrings = String.TabBarLocalizedStringKeys.self
    
    public init(viewControllersProvider: @escaping () -> [String : UIViewController]) {
        self.viewControllersProvider = viewControllersProvider
    }
    
    public func initialize () {
        screensState = .loading
        Task {
             await configureTabs()
        }
    }
    
    @MainActor
    private func configureTabs() async {
        let viewControllers = viewControllersProvider()
        var configuratedTabs =  [UIViewController]()
        for (key, viewController) in viewControllers {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem = getTabBarItem(key: key)
            configuratedTabs.append(navigationController)
        }
        self.screensState = .success(configuratedTabs)
    }
    
    private func getTabBarItem(key: String) -> UITabBarItem {
        let title: String
        let icon: UIImage?
        let selectedIcon: UIImage?
        
        switch key {
        case "settings":
            title = localizedStrings.TabBarViewModelSettingsScreenTitle
            icon = UIImage(systemName: "gearshape")
            selectedIcon = UIImage(systemName:"gearshape.fill" )
        case "home":
            title = localizedStrings.TabBarViewModelHomeScreenTitle
            icon = UIImage(systemName: "house")
            selectedIcon = UIImage(systemName:"house.fill" )
        default:
            title = localizedStrings.TabBarViewModelDefaultScreenTitle
            icon = UIImage(systemName: "questionmark.circle")
            selectedIcon = UIImage(systemName: "questionmark.circle.fill")
        }
        return UITabBarItem(title: title, image: icon, selectedImage: selectedIcon)
    }
}

public enum ScreensState: Equatable {
    case loading
    case error(String)
    case success([UIViewController])
    
    public static func == (lhs: ScreensState, rhs: ScreensState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.error(let lhsMessage), .error(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.success(let lhsViewControllers), .success(let rhsViewControllers)):
            return lhsViewControllers.count == rhsViewControllers.count
        default:
            return false
        }
    }
}
