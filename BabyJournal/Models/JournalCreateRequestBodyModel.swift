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

    init(
        unit: String = "",
        notes: String = "",
        duration: String = "",
        mood: String = "",
        temperature: String = "",
        feedingType: String = "",
        diaperDetails: String = "",
        sleepQuality: String = "",
        cryingReason: String = "",
        activityDetails: String = ""
    ) {
        self.unit = unit
        self.notes = notes
        self.duration = duration
        self.mood = mood
        self.temperature = temperature
        self.feedingType = feedingType
        self.diaperDetails = diaperDetails
        self.sleepQuality = sleepQuality
        self.cryingReason = cryingReason
        self.activityDetails = activityDetails
    }
}
