//
//  SettingsModule.swift
//  SettingsModule
//
//  Created by Cincinnati Ai on 8/7/25.
//

import SwiftUI

public struct SettingsScreen: View {
    @ObservedObject var languageManager = LanguageManager.shared
    
    public init () { }
    public var body: some View {
        Form {
            Section(header: Text("Language")) {
                Picker("Select Language", selection: $languageManager.currentLanguage) {
                    ForEach(AppLanguage.allCases) { lang in
                        Text(lang.displayName).tag(lang)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle("Settings")
    }
}
