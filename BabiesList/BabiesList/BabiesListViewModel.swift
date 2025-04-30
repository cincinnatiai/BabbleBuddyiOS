//
//  BabiesListViewModel.swift
//  BabiesList
//
//  Created by Trainee on 4/21/25.
//

import Foundation
import UIKit

public class BabiesListViewModel {
    @Published var babiesState: BabiesState = .loading
    private var accountApi: () async -> Result<[AccountResponseModel],Error>
    
    public init(accountApi: @escaping () -> Result<[AccountResponseModel], Error>) {
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
    
    private func transformToDisplayableBabies(response: [AccountResponseModel]) async -> [DisplayableBaby] {
        let babies = response.compactMap { element -> DisplayableBaby? in
            guard
                let baby = element.account,
                let babyName = baby.title,
                let babyDescription = baby.description
            else { return nil }
            return DisplayableBaby(name: babyName, description: babyDescription)
        }
        return babies
    }
}

public enum BabiesState: Equatable {
    case loading
    case error(String)
    case success([DisplayableBaby])
    
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

