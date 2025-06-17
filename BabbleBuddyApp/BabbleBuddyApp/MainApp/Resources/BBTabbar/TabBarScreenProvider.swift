//
//  File.swift
//  BabbleBuddyApp
//
//  Created by GenericDevGeorgia on 6/13/25.
//

import SwiftUI
import TabBar
import AuthLibrarySPM
import CoreKit
import BabiesListAndRegistration

public class TabBarScreenProvider {
    static func makeBabiesListView(userEmail: String) -> UIViewController {
        guard
            let baseURL = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue),
            let idToken = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue),
            !baseURL.isEmpty, !idToken.isEmpty
        else {
            // TODO: If there is no baseURL or idToken no view should exist, here should be performed sign out
            let vc = UIViewController()
            vc.title = "Error no baseURL or idToken"
            return vc
        }

        let service = BBAServiceImplementation(
            baseURL: baseURL, token: idToken
        )

        let viewModel = BabiesListViewModel(accountApi: {
            await service.fetchBabies()
        }, babyService: service, userEmail: userEmail
        )

        return BabiesListView(viewModel: viewModel)
    }
}
