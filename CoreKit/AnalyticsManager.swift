//
//  AnalyticsManager.swift
//  CoreKit
//
//  Created by CincinnatiAI Dallas on 4/2/25.
//

import Foundation
import FirebaseAnalytics
import FirebaseCrashlytics

public final class AnalyticsManager {
    public static let shared = AnalyticsManager()

    private init() {}

    public func logEvent(_ name: String, parameters: [String: Any]? = nil) {
        Analytics.logEvent(name, parameters: parameters)
    }

    public func logCrash(_ message: String) {
        Crashlytics.crashlytics().log(message)
    }

    public func recordNonFatalError(_ error: Error) {
        Crashlytics.crashlytics().record(error: error)
    }

    public func setCustomValue(_ value: Any, forKey key: String) {
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
    }

    public func forceCrash() {
        fatalError("Forced crash for testing Crashlytics")
    }
}
