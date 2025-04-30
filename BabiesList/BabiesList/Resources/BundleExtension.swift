//
//  BundleExtension.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation

final class BabiesListModuleIdentifier {}

extension Bundle {
    public static var babiesListModule: Bundle {
        return Bundle(for: BabiesListModuleIdentifier.self)
    }
}
