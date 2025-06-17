//
//  BabiesListViewModel.swift
//  BabiesListAndRegistration
//
//  Created by Trainee on 4/21/25.
//

import Foundation
import UIKit

public class BabiesListViewModel {
    // MARK: Published properties
    @Published var babiesState: BabiesState = .loading

    // MARK: Private properties
    private var accountApi: () async -> Result<[BabiesResponseProtocol], Error>
    private let babyService: BBAServiceProtocol
    private let userEmail: String

    // MARK: Initializer
    public init(
        accountApi: @escaping () async -> Result<[BabiesResponseProtocol], Error>,
        babyService: BBAServiceProtocol,
        userEmail: String
    ) {
        self.accountApi = accountApi
        self.babyService = babyService
        self.userEmail = userEmail
    }

    // MARK: Public methods
    func initialize() {
        babiesState = .loading
        Task {
            let response = await accountApi()
            switch response {
            case .success(let result):
                let babies = await transformToDisplayableBabies(response: result)
                await MainActor.run {
                    babiesState = .success(babies)
                }
            case.failure(let error):
                await MainActor.run {
                    babiesState = .error(error.localizedDescription)
                }
            }
        }
    }

    func createBabyRegistrationViewModel() -> BabyRegistrationViewModel {
        return BabyRegistrationViewModel(userEmail: userEmail, createAPI: { request in
            try await self.babyService.createBaby(request: request)
        })
    }

    // MARK: Private methods
    private func transformToDisplayableBabies(response: [BabiesResponseProtocol]) async -> [DisplayableBabyItem] {
        let babies = response.compactMap { element -> DisplayableBabyItem? in
            guard
                let baby = element.account,
                let babyName = baby.title,
                let babyDescription = baby.description
            else { return nil }
            return DisplayableBabyItem(
                imageURL: "",
                title: babyName,
                details: [babyDescription]
            )
        }
        return babies
    }

    public enum BabiesState: Equatable {
        case loading
        case error(String)
        case success([DisplayableBabyItem])

        public static func == (lhs: BabiesState, rhs: BabiesState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.error(let lhsMessage), .error(let rhsMessage)):
                return lhsMessage == rhsMessage
            case (.success(let lhsViewControllers), .success(let rhsViewControllers)):
                return lhsViewControllers.count == rhsViewControllers.count
            default:
                return false
            }
        }
    }
}
