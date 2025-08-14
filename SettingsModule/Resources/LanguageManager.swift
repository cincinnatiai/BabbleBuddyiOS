//
//  LanguageManager.swift
//  SettingsModule
//
//  Created by Cincinnati Ai on 8/8/25.
//
import Combine
import Foundation

public protocol LanguageConfigurableModule {
    var moduleId: ModuleIdentifier { get }
    var baseBundle: Bundle { get }
}

public final class LanguageManager: ObservableObject {
    public static let shared = LanguageManager()
    private var registeredModules: [ModuleIdentifier: Bundle] = [:]
    
    @Published public var currentLanguage: AppLanguage {
        didSet {
            saveLanguage(currentLanguage)
            reloadBundles()
            NotificationCenter.default.post(name: .languageDidChange, object: currentLanguage)
        }
    }
    
    private init () {
        if let saved = UserDefaults.standard.string(forKey: "appLanguage"),
           let langauage = AppLanguage(rawValue: saved) {
            currentLanguage = langauage
        } else {
            currentLanguage = .english
        }
        reloadBundles()
    }
    
    public func registerModule(_ module: LanguageConfigurableModule) {
        registeredModules[module.moduleId] = module.baseBundle
        Bundle.setLanguage(
            bundle: bundleForLanguage(currentLanguage.rawValue, baseBundle: module.baseBundle),
            for: module.moduleId
        )
    }

    private func saveLanguage(_ language: AppLanguage) {
        UserDefaults.standard.set(language.rawValue, forKey: "appLanguage")
    }
    
    private func reloadBundles() {
        for (moduleId, baseBundle) in registeredModules {
            Bundle.setLanguage(
                bundle: bundleForLanguage(currentLanguage.rawValue, baseBundle: baseBundle),
                for: moduleId
            )
        }
    }
    
    private func bundleForLanguage(_ languageCode: String, baseBundle: Bundle) -> Bundle {
        if let path = baseBundle.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        }
        return baseBundle
    }
}

public extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}
