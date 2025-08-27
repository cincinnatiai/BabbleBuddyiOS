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
    private var viewModel: BabiesListViewModel?
    private var navigationController: UINavigationController?
    private let babyService: BBABabiesServiceProtocol
    private var registrationCoordinator: BabyRegistrationCoordinator?
    private var user = ""

    // MARK: Initialize
    public init(
        babyService: BBABabiesServiceProtocol
    ) {
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
        let view = BabiesListView(viewModel: viewModel, onAddBabyTapped: { navController in
            self.navigateToBabyRegistration(navController: navController)
        }, onEditBabbyTapped: { navController, baby in
            viewModel.fetchBaby(id: baby.rangeKey) { result in
                switch result {
                case .success(let babyDetails):
                    self.navigateToEditBaby(navController: navController, baby: babyDetails)
                case .failure: break
                // TODO: handle error
                }
            }
        })
        return view
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
    
    private func navigateToEditBaby(
        navController: UINavigationController,
        baby: CreateBabyResponseProtocol
    ) {
        registrationCoordinator = BabyRegistrationCoordinator(
            service: babyService,
            existingBaby: baby,
            userEmail: user,
            navigationController: navController,
            onSuccessfulRegistration: {
                self.viewModel?.initialize()
            }
        )
        registrationCoordinator?.start()
    }
}
