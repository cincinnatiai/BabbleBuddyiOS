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
            title = "Settings"
            icon = UIImage(systemName: "gearshape")
            selectedIcon = UIImage(systemName:"gearshape.fill" )
        case "home":
            title = "HomeView"
            icon = UIImage(systemName: "house")
            selectedIcon = UIImage(systemName:"house.fill" )
        default:
            title = "Tab"
            icon = UIImage(systemName: "questionmark.circle")
            selectedIcon = UIImage(systemName: "questionmark.circle.fill")
        }
        return UITabBarItem(title: title, image: icon, selectedImage: selectedIcon)
    }
}

public enum ScreensState {
    case loading
    case error(String)
    case success([UIViewController])
}
