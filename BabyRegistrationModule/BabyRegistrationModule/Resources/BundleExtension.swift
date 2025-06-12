//
//  BundleExtension.swift
//  BabyRegistrationModule
//
//  Created by Trainee on 4/24/25.
//

import Foundation

final class BabyRegistrationModuleIdentifier {}

extension Bundle {
    static var babyRegistrationModule: Bundle {
        return Bundle(for: BabyRegistrationModuleIdentifier.self)
    }
}
