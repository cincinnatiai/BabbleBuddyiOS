import UIKit
import DesignKit
import Combine
import SwiftUI

public final class BabiesListCoordinator: BBCoordinator {
    
    private let babyService: BBABabiesServiceProtocol
    private let accountApi: () async throws -> [BabiesResponseProtocol]
    private let userEmail: String
    private var viewModel: BabiesListViewModel?
    private var babiesListVC: BabiesListView?
    
    public init(
        accountApi: @escaping () async throws -> [BabiesResponseProtocol],
        babyService: BBABabiesServiceProtocol,
        userEmail: String
    ) {
        self.accountApi = accountApi
        self.babyService = babyService
        self.userEmail = userEmail
        start()
    }
    
    public func start() {
        let viewModel = BabiesListViewModel(
            accountApi: accountApi,
            babyService: babyService,
            userEmail: userEmail
        )
        self.viewModel = viewModel
        let babiesListVC = BabiesListView(viewModel: viewModel)
        self.babiesListVC = babiesListVC
    }
    
    public func createView()  {
    }
    
    public func navigateToBabiesListVeiw() -> UIViewController{
        guard let viewModel else { return UIViewController() }
        return BabiesListView(viewModel: viewModel)
    }
}
