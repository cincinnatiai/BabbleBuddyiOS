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
    private var accountApi: () async throws -> [BabiesResponseProtocol]
    private let babyService: BBABabiesServiceProtocol
    private let userEmail: String

    // MARK: Initializer
    public init(
        accountApi: @escaping () async throws -> [BabiesResponseProtocol],
        babyService: BBABabiesServiceProtocol,
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
            do {
                let response = try await accountApi()
                let babies = await transformToDisplayableBabies(response: response)
                await MainActor.run {
                    babiesState = .success(babies)
                }
            } catch {
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
    private func transformToDisplayableBabies(response: [BabiesResponseProtocol]) async -> [BabyCardDisplayModel] {
        return response.compactMap { element in
            guard
                let baby = element.account,
                let babyName = baby.title,
                let babyDescription = baby.description
            else { return nil }

            let gender = extractGender(from: baby.metadata)

            let displayItem = DisplayableBabyItem(
                imageURL: "",
                title: babyName,
                details: [babyDescription]
            )

            return BabyCardDisplayModel(baby: displayItem, gender: gender)
        }
    }

    private func extractGender(from metadata: String?) -> String? {
        guard
            let data = metadata?.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let gender = json["gender"] as? String
        else { return nil }

        return gender
    }



    public enum BabiesState: Equatable {
        case loading
        case error(String)
        case success([BabyCardDisplayModel])

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
