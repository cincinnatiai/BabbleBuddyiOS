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
    private var infoProvider: () async -> Result<[AccountResponseModel],Error>
    
    public init(infoProvider: @escaping () -> Result<[AccountResponseModel], Error>) {
        self.infoProvider = infoProvider
    }
    
    func initialize() {
        babiesState = .loading
        Task {
            let response = await infoProvider()
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
                let babyDateOfBirth = baby.description
            else { return nil }
            return DisplayableBaby(name: babyName, dateOfBirth: babyDateOfBirth)
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

