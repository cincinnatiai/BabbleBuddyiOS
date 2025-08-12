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
    // MARK: Shared resources
    static private let idToken: String = {
        guard let token = KeychainHelper.shared.read(
            forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue
        ) else {
            return ""
        }
        return token
    }()

    static private let baseURL: String = {
        guard let url = KeychainHelper.shared.read(
            forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue
        ) else {
            return ""
        }
        return url
    }()

    static private let networkClient = NetworkClient(token: idToken)

    static private let babyService = BBABabiesServiceImplementation(
        client: networkClient,
        baseURL: baseURL
    )

    static private let journalService = BBAJournalService(client: networkClient, baseURL: baseURL)

    // MARK: Views
    static func makeBabiesListView() -> UIViewController {
        let coordinator = BabiesListCoordinator(
            babyService: babyService
        )

        return coordinator.navigateToBabiesList()
    }

    static func makeJournalView() -> any View {
        let coordinator = BabyJournalViewCoordinator(
            babyService: babyService,
            journalService: journalService
        )

        return coordinator.navigateToBabyJournalView()
    }
}
