//
//  BabyJournalViewCoordinator.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 8/1/25.
//

import DesignKit
import BabiesListAndRegistration
import SwiftUI

public final class BabyJournalViewCoordinator: BBCoordinator {
    private var viewModel: BabyJournalViewModel?
    private let babyService: BBABabiesServiceProtocol
    private let journalService: BabyJournalServiceProtocol

    public init(babyService: BBABabiesServiceProtocol, journalService: BabyJournalServiceProtocol) {
        self.babyService = babyService
        self.journalService = journalService
        /// For this particular case, since the tabbar contains the navigation stack and the navigationController, we just need to provide the screen to the tabbar
        start()
    }

    public func start() {
        viewModel = BabyJournalViewModel(
            journalService: journalService,
            babiesService: babyService
        )
    }

    public func createView() {
    }

    public func navigateToBabyJournalView() -> any View {
        guard let viewModel else { return EmptyView()}
        return BabyJournalView(viewModel: viewModel)
    }
}
