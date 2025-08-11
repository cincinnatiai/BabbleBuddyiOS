import UIKit
import DesignKit
import Combine
import SwiftUI

public final class BabiesListCoordinator: BBCoordinator {
    public func createView() {
    }
    
    private let babyService: BBABabiesServiceProtocol
    private let userEmail: String
    private var viewModel: BabiesListViewModel?
    private var babiesListVC: BabiesListView?

    public init(
        babyService: BBABabiesServiceProtocol,
        userEmail: String
    ) {

        self.babyService = babyService
        self.userEmail = userEmail
        start()
    }

    public func start() {
        let viewModel = BabiesListViewModel(
            babyService: babyService,
            userEmail: userEmail
        )
        self.viewModel = viewModel
        self.babiesListVC = BabiesListView(viewModel: viewModel)
    }

    public func navigateToBabiesListView() -> UIViewController {
        guard let viewModel else { return UIViewController() }
        return BabiesListView(viewModel: viewModel)
    }
}
