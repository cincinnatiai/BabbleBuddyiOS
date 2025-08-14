//
//  AppLanguage.swift
//  SettingsModule
//
//  Created by Cincinnati Ai on 8/8/25.
//

public enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case spanish = "es"
    case korean = "ko"
    
    public var id: String { rawValue }
    
    public var displayName: String {
        switch self {
        case .english:
            return "English"
        case .spanish:
            return "Español"
        case .korean:
            return "한국어"
        }
    }
}
