//
//  BundleExtension.swift
//  TabBar
//
//  Created by Trainee on 4/3/25.
//

import Foundation

final class TabBarModuleIdentifier {}

extension Bundle {
    static var tabBarModule: Bundle {
        return Bundle(for: TabBarModuleIdentifier.self)
    }
}
