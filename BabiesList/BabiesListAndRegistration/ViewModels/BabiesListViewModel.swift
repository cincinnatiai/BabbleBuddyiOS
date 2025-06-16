//
//  BabiesListViewModel.swift
//  BabiesListAndRegistration
//
//  Created by Trainee on 4/21/25.
//

import Foundation
import UIKit

public class BabiesListViewModel {
    @Published var babiesState: BabiesState = .loading
    private var accountApi: () async -> Result<[BabiesResponseProtocol], Error>

    public init(accountApi: @escaping () async -> Result<[BabiesResponseProtocol], Error>) {
        self.accountApi = accountApi
    }
    
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

