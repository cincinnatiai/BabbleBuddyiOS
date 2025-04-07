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

public class TabBarViewModel : ObservableObject {
    @Published var screensState : ScreensState = .loading
    private let viewControllersProvider : () -> [String : UIViewController]
    private let localizedStrings = TabBarLocalizedStringKeys.self
    
    public init(viewControllersProvider: @escaping () -> [String : UIViewController]) {
        self.viewControllersProvider = viewControllersProvider
        initialize()
    }
    
    public func initialize () {
        screensState = .loading
        Task {
            let viewControllers = await MainActor.run { viewControllersProvider() }
            await configureTabs(elements: viewControllers)
        }
    }
    
    private func sortKeys(elements : [String : UIViewController]) async -> [String] {
        let preferredOrder: [TabBarItemKey] = [.home, .settings]
        let preferredKeys = preferredOrder.map(\.rawValue)
        let existingPreferredKeys = preferredKeys.filter { elements.keys.contains($0) }
        let remainingKeys = elements.keys.filter { !preferredKeys.contains($0) }
        return existingPreferredKeys + remainingKeys
        }
    
    @MainActor
    private func configureTabs(elements : [String : UIViewController]) async {
        let sortedKeys = await sortKeys(elements: elements)
        var configuratedTabs =  [UIViewController]()
        for key in sortedKeys {
            guard let viewController = elements[key] else {continue}
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem = getTabBarItem(key: key)
            configuratedTabs.append(navigationController)
        }
        screensState = .success(configuratedTabs)
    }
    
    private func getTabBarItem(key : String) -> UITabBarItem {
        let title: String
        let icons: (String,String)
        
        switch TabBarItemKey(rawValue: key) {
        case .settings :
            title = localizedStrings.TabBarViewModelSettingsScreenTitle
            icons = TabBarIcons.settings
        case .home :
            title = localizedStrings.TabBarViewModelHomeScreenTitle
            icons = TabBarIcons.home
        default:
            title = localizedStrings.TabBarViewModelDefaultScreenTitle
            icons = TabBarIcons.unknown
        }
        return UITabBarItem(title: title, image: UIImage(systemName: icons.0), selectedImage: UIImage(systemName: icons.1))
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
