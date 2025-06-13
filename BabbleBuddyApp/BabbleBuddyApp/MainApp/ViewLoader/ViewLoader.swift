import Foundation
import SwiftUI

// MARK: - ViewLoader

/// Entry point view that decides whether to show a loading indicator
/// or render the main tab bar, based on `ViewLoaderViewModel` readiness.
struct ViewLoader: View {
    
    // MARK: - Dependencies
    
    private let localizedStrings = LocalizedStringKeys.self
    @ObservedObject var viewModel: ViewLoaderViewModel
    
    var body: some View {
        Group {
            ProgressView(localizedStrings.ViewLoaderLoadingLabel)
        }
    }
}
