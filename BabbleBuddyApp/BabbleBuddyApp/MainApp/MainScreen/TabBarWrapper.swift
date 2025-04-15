//
//  TabBarWrapper.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 4/14/25.
//

import Foundation
import SwiftUI
import TabBar
import AuthLibrarySPM

struct TabBarWrapper: UIViewControllerRepresentable {
    let viewControllers: [String: UIViewController]
    
    func makeUIViewController(context: Context) -> TabBarView {
        return TabBarView(viewModel: TabBarViewModel(viewControllersProvider: { viewControllers }))
        
    }
    
    func updateUIViewController(_ uiViewController: TabBarView, context: Context) {}
    
}
