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
import NetworkingKit
import BabyJournal

public class TabBarScreenProvider {
    static private let idToken: String = {
        guard let token = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue) else {
            return ""
        }
        return token
    }()

    static private let baseURL: String = {
        guard let token = KeychainHelper.shared.read(
            forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue
        ) else {
            return ""
        }
        return token
    }()

    static private let networkClient = NetworkClient(token: idToken)

    static private let babyService = BBABabiesServiceImplementation(
        client: networkClient,
        baseURL: baseURL
    )

    static private let journalService = BBAJournalService(client: networkClient, baseURL: baseURL)


    static func makeBabiesListView(userEmail: String) -> UIViewController {
        guard
            let baseURL = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue),
            let idToken = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue),
            !baseURL.isEmpty, !idToken.isEmpty
        else {
            // TODO: If there is no baseURL or idToken no view should exist, here should be performed sign out
            let viewController = UIViewController()
            viewController.title = "Error no baseURL or idToken"
            return viewController
        }

        let networkClient = NetworkClient(token: idToken)

        let service = BBABabiesServiceImplementation(
            client: networkClient, baseURL: baseURL
        )

        let viewModel = BabiesListViewModel(accountApi: {
            try await service.fetchBabies()
        }, babyService: service, userEmail: userEmail
        )

        return BabiesListView(viewModel: viewModel)
    }

    static func makeJournalView() -> any View {
        let coordinator = BabyJournalViewCoordinator(
            baseUrl: baseURL,
            idToken: idToken,
            babyService: babyService,
            journalService: journalService
        )

        return coordinator.navigateToBabyJournalView()
    }
}
