//
//  DisplayableBaby.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

public struct BabyCardDisplayModel {
    let baby: DisplayableBabyItem
    let gender: String?
}

public struct DisplayableBabyItem {
    let imageURL: String?
    let title: String
    let details: [String]?
}
