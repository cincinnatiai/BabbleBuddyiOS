//
//  File.swift
//  BabbleBuddyApp
//
//  Created by GenericDevGeorgia on 6/13/25.
//

import SwiftUI
import TabBar
import AuthLibrarySPM
import BabiesList
import NetworkingKit

public class TabBarScreenProvider {
    static func makeBabiesListView() -> BabiesListView {
        guard
            let baseURL = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.baseURL.rawValue),
            let idToken = KeychainHelper.shared.read(forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue),
            !baseURL.isEmpty, !idToken.isEmpty
        else {
            return BabiesListView(viewModel: BabiesListViewModel(accountApi: {
                .failure(ServiceErrors.missingAuthToken)
            }))
        }

        let service = BabiesListServiceImplementation(
            baseURLProvider: { baseURL },
            tokenProvider: { idToken }
        )

        let viewModel = BabiesListViewModel(accountApi: {
            await service.fetchBabies()
        })

        return BabiesListView(viewModel: viewModel)
    }

}

