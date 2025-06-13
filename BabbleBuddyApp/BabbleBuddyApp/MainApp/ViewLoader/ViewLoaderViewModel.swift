import Foundation
import TabBar
import UIKit
import AuthLibrarySPM
import SwiftUI
import BabiesList
import NetworkingKit

class ViewLoaderViewModel: ObservableObject {

    // MARK: - Private State
    private var accounts: Result<[AccountResponseModel], Error>?
    private var serviceAccount: BabyAccountService?


    private func initializeService() {
        self.serviceAccount = BabiesListServiceImplementation(
            baseURLProvider: TokenProviderService.baseURL,
            tokenProvider: TokenProviderService.token
        )
    }
}
