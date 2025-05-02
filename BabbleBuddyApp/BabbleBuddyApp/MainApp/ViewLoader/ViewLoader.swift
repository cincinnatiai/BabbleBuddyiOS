//
//  ViewLoader.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 5/1/25.
//

import Foundation
import SwiftUI

struct ViewLoader: View {
    private let localizedStrings = LocalizedStringKeys.self
    @ObservedObject var viewModel: ViewLoaderViewModel

    var body: some View {
        Group {
            if viewModel.isReady {
                TabBarWrapper(viewControllers: viewModel.viewControllers)
            } else {
                ProgressView(localizedStrings.ViewLoaderLoadingLabel)
                    .onAppear {
                        viewModel.initializeData()
                    }
            }
        }
    }
}
