//
//  TabBarView.swift
//  TabBar
//
//  Created by Trainee on 4/1/25.
//

import Foundation
import Combine
import UIKit

// TODO: Currently not used, review to extract key functionalities
public class TabBarView: UITabBarController {
    
    private var viewModel: TabBarViewModel
    private var cancellables = Set<AnyCancellable>()
    private let localizedStrings = TabBarLocalizedStringKeys.self
    
    private var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    public init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(localizedStrings.FatalErrorMessage)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
        setupLoader()
    }
    
    private func setupLoader() {
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showLoader() {
        loader.startAnimating()
    }
    
    private func hideLoader() {
        loader.stopAnimating()
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: localizedStrings.TabBarViewErrorAlertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localizedStrings.TabBarViewErrorAlertButton, style: .default, handler: nil))
            present(alert, animated: true)
        }
    
    private func observeViewModel() {
        viewModel.$screensState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    showLoader()
                case .error(let message):
                    showErrorAlert(message: message)
                    hideLoader()
                case .success(let viewControllers):
                    self.viewControllers = viewControllers
                    hideLoader()
                }
            }
            .store(in: &cancellables)
    }
}

import SwiftUI

public struct TabBarViewV2: View {
    private let tabs: [TabItem]

    public init(tabs: [TabItem]) {
        self.tabs = tabs
    }

    public var body: some View {
        TabView {
            ForEach(Array(tabs.enumerated()), id: \.offset) { _, tab in
                tabContentView(tab)
                    .tabItem {
                        Image(systemName: tab.icon)
                        Text(tab.title)
                    }
            }
        }
    }

    @ViewBuilder
    private func tabContentView(_ tab: TabItem) -> some View {
        switch tab.content {
        case .swiftUIView(let view):
            NavigationStack {
            view
            }
        case .viewController(let vc):
            ViewControllerWrapper(viewController: vc)
        }
    }
}
