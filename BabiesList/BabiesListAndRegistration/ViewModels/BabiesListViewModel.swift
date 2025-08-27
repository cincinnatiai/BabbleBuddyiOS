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
    private let babyService: BBABabiesServiceProtocol
    private let onSuccessFetchedBabies: (String) -> Void
    private var user: String = ""
    private let cincinnatiBabyService = "CincinnatiBabyService"

    // MARK: Initializer
    public init(
        babyService: BBABabiesServiceProtocol,
        onSuccessFetchedBabies: @escaping (String) -> Void
    ) {
        self.babyService = babyService
        self.onSuccessFetchedBabies = onSuccessFetchedBabies
    }

    // MARK: Public methods
    func initialize() {
        babiesState = .loading
        Task {
            do {
                let response = try await babyService.fetchBabies()
                let babies = await transformToDisplayableBabies(response: response)
                user = response[0].accountProfile?.encryptedEmail?
                    .base64DecodedString() ?? ""

                if !user.isEmpty {
                    onSuccessFetchedBabies(user)
                }
                
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

    func fetchBaby(
        id: String,
        completion: @escaping (Result<CreateBabyResponseProtocol, Error>) -> Void
    ) {
        Task {
            do {
                let response = try await babyService.fetchBaby(with: id)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func deleteBaby(
        baby: BabyCardDisplayModel,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        Task {
            do {
                let request = DeleteBabyRequestModel(
                    isHardDelete: true,
                    partitionKey: cincinnatiBabyService,
                    rangeKey: baby.rangeKey,
                    userId: user
                )
                let success = try await babyService.deleteBaby(request: request)
                if success {
                    initialize()
                }
                completion(.success(success))
            } catch {
                completion(.failure(error))
            }
        }
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
            let rangeKey = baby.rangeKey ?? ""

            let displayItem = DisplayableBabyItem(
                imageURL: "",
                title: babyName,
                details: [babyDescription]
            )

            return BabyCardDisplayModel(
                rangeKey: rangeKey,
                baby: displayItem,
                gender: gender
            )
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
