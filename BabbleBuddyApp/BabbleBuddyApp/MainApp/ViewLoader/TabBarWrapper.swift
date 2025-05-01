//
//  TabBarWrapper.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 5/1/25.
//

import Foundation
import SwiftUI
import TabBar
import AuthLibrarySPM

struct TabBarWrapper: UIViewControllerRepresentable {
    let viewControllers: [String: UIViewController]
    
    func makeUIViewController(context: Context) -> TabBarView {
        let tabBarViewModel = TabBarViewModel(viewControllersProvider: { viewControllers })
        return TabBarView(viewModel: tabBarViewModel)
    }
    
    func updateUIViewController(_ uiViewController: TabBarView, context: Context) {}
}
