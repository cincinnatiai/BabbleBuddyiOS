//
//  JournalCreateRequestBodyModel.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

public struct BabyEventBodyModel: Codable, Hashable {
    public let unit: String
    public let notes: String
    public let duration: String
    public let mood: String
    public let temperature: String
    public let feedingType: String
    public let diaperDetails: String
    public let sleepQuality: String
    public let cryingReason: String
    public let activityDetails: String
}
