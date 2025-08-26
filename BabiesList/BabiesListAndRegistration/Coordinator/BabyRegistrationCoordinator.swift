//
//  BabyRegistrationCoordinator.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 8/11/25.
//

import DesignKit
import UIKit
import SwiftUI

final class BabyRegistrationCoordinator: BBCoordinator {
    // MARK: Private properties
    private var viewModel: BabyRegistrationViewModel?
    private var view: BabyRegistrationView?
    private let service: BBABabiesServiceProtocol
    private let userEmail: String
    private let navigationController: UINavigationController
    private let onSuccessfulRegistration: () -> Void
    private let localizedStrings = BabiesListLocalizedStringKeys.self
    private let existingBaby: CreateBabyResponseProtocol?

    // MARK: Initialization
    init(
        service: BBABabiesServiceProtocol,
        existingBaby: CreateBabyResponseProtocol? = nil,
        userEmail: String,
        navigationController: UINavigationController,
        onSuccessfulRegistration: @escaping () -> Void
    ) {
        self.service = service
        self.existingBaby = existingBaby
        self.navigationController = navigationController
        self.userEmail = userEmail
        self.onSuccessfulRegistration = onSuccessfulRegistration
    }

    func start() {
        viewModel = BabyRegistrationViewModel(
            userEmail: userEmail,
            babyService: service,
            existingBaby: existingBaby
        )
        guard let viewModel = viewModel else { return }
        view = BabyRegistrationView(viewModel: viewModel) { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController.popViewController(animated: true)
                self?.onSuccessfulRegistration()
            }
        }
        createView()
    }

    func createView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let registrationVC = UIHostingController(rootView: view)
            registrationVC.title = localizedStrings.BabyRegistrationScreenTitle
            self.navigationController.pushViewController(registrationVC, animated: true)
        }
    }
}
