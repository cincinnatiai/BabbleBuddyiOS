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
    private static let tokenManager = TokenHandler()

    static private let baseURL: String = {
        guard let url = KeychainHelper.shared.read(
            forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue
        ) else {
            return ""
        }
        return url
    }()

    private static func createNetworkClient() -> NetworkClient {
        NetworkClient(
            token: tokenManager.getIdToken() ?? ""
        )
    }

    private static var babyService: BBABabiesServiceImplementation {
          BBABabiesServiceImplementation(client: createNetworkClient(), baseURL: baseURL)
      }

      private static var journalService: BBAJournalService {
          BBAJournalService(client: createNetworkClient(), baseURL: baseURL)
      }

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
