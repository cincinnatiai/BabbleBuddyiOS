//
//  BundleExtension.swift
//  SplashViewModule
//
//  Created by Trainee on 4/10/25.
//

import Foundation

final class SplashViewModuleIdentifier {}

extension Bundle {
    static var SplashViewModule: Bundle {
        return Bundle(for: SplashViewModuleIdentifier.self)
    }
}
