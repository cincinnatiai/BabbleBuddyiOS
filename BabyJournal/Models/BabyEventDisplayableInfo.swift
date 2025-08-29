struct BabyEventDisplayableInfo {
    public let eventType: String
    public let eventDate: String
    public let partitionKey: String
    public let rangeKey: String
    public let userId: String
    public let notes: String?
    public let mood: String?
    public let temperature: String?
    public let feedingType: String?
    public let diaperDetails: String?
    public let sleepQuality: String?
    public let cryingReason: String?
    public let activityDetails: String?

    init(eventType: String, eventDate: String, partitionKey: String, rangeKey :String, userId: String, notes: String? = nil, mood: String? = nil, temperature: String? = nil, feedingType: String? = nil, diaperDetails: String? = nil, sleepQuality: String? = nil, cryingReason: String? = nil, activityDetails: String? = nil) {
        self.eventType = eventType
        self.eventDate = eventDate
        self.partitionKey = partitionKey
        self.rangeKey = rangeKey
        self.userId = userId
        self.notes = notes
        self.mood = mood
        self.temperature = temperature
        self.feedingType = feedingType
        self.diaperDetails = diaperDetails
        self.sleepQuality = sleepQuality
        self.cryingReason = cryingReason
        self.activityDetails = activityDetails
    }
}
