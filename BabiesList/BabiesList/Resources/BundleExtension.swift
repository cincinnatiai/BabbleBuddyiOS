//
//  BundleExtension.swift
//  babiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation

final class BabyListModuleIdentifier {}

extension Bundle {
    public static var babyListModule: Bundle {
        return Bundle(for: BabyListModuleIdentifier.self)
    }
}
