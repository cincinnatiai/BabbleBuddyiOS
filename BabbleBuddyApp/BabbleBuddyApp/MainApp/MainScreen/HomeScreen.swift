//
//  HomeScreen.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 4/24/25.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    private var localizedStrings = LocalizedStringKeys.self
    var body: some View {
        Text(localizedStrings.HomeScreenLabel)
    }
}
