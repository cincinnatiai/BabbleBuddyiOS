//
//  HomeScreen.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 4/15/25.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    private let localizedStrings = LocalizedStringKeys.self
    var body: some View {
        Text(localizedStrings.HomeScreenLabel)
    }
}
