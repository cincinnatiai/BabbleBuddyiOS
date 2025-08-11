//
//  BabiesListCoordinator.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 8/11/25.
//

import DesignKit
import SwiftUI

public final class BabiesListCoordinator: BBCoordinator {
    // MARK: Private properties
    private let baseUrl: String
    private let idToken: String
    private var viewModel: BabiesListViewModel?
    private var navigationController: UINavigationController?
    private let babyService: BBABabiesServiceProtocol
    private var registrationCoordinator: BabyRegistrationCoordinator?
    private var user = ""

    // MARK: Initialize
    public init(
        baseUrl: String,
        idToken: String,
        babyService: BBABabiesServiceProtocol
    ) {
        self.baseUrl = baseUrl
        self.idToken = idToken
        self.babyService = babyService
        start()
    }

    public func start() {
        viewModel = BabiesListViewModel(
            babyService: babyService
        ) { [weak self] userEmail in
            self?.user = userEmail
        }
    }

    public func navigateToBabiesList() -> UIViewController {
        guard let viewModel else { return UIViewController()}

        return BabiesListView(viewModel: viewModel) { navController in
            self.navigateToBabyRegistration(navController: navController)
        }
    }

    public func createView() {}

    // MARK: Private methods
    private func navigateToBabyRegistration(
        navController: UINavigationController
    ){
        registrationCoordinator = BabyRegistrationCoordinator(
            service: babyService,
            userEmail: user,
            navigationController: navController,
            onSuccessfulRegistration: {
                self.viewModel?.initialize()
            }
        )
        registrationCoordinator?.start()
    }
}
