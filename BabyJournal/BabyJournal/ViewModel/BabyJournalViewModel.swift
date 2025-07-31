//
//  BabyJournalViewModel.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/15/25.
//

import BabiesListAndRegistration
import Foundation
import Combine
import DesignKit
import CoreKit

final public class BabyJournalViewModel: ObservableObject {
    // MARK: Public properties

    @Published var state: UIState = .loading

    enum UIState {
        case loading
        case loaded([String], [BabyEventDisplayableInfo])
        case error(error: Error)
        case noBabies
    }

    // MARK: Private properties

    private let journalService: BabyJournalServiceProtocol
    private let babiesService: BBABabiesServiceProtocol
    private var babies: [BabiesResponseProtocol] = []
    private var babiesNames: [String] = []
    private var babyEvents: [BabyEventProtocol] = []
    private var displayableEvents: [BabyEventDisplayableInfo] = []
    private var currentBabyIndex = 0
    private var currentDate = Date()

    private let userDefaults: UserDefaultsServiceProtocol = UserDefaultsService.shared
    private let sleepStart = "SLEEP_START"
    private let sleepEnd = "SLEEP_END"
    private let playStart = "PLAY_START"
    private let playEnd = "PLAY_END"

    // MARK: Initializer

    public init(
        journalService: BabyJournalServiceProtocol,
        babiesService: BBABabiesServiceProtocol
    ) {
        self.journalService = journalService
        self.babiesService = babiesService
        fetchBabies()
    }

    // MARK: Private methods

    private func fetchBabies(){
        Task{
            await MainActor.run {
                state = .loading
            }
            do {
                let babiesResponse = try await babiesService.fetchBabies()
                babies = babiesResponse
                babiesNames = babiesResponse.compactMap { $0.account?.title }

                if babies.isEmpty {
                    await MainActor.run {
                        state = .noBabies
                    }
                } else {
                    createJournalFetchRequest(
                        selectedBabyIndex: currentBabyIndex,
                        selectedDate: currentDate
                    )
                }
            } catch {
                await MainActor.run {
                    state = .error(error: error)
                }
            }
        }
    }

    private func transforToDisplayableEvent(event: BabyEventProtocol) -> BabyEventDisplayableInfo {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = isoFormatter.date(from: event.rangeKey) ?? Date()
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        displayFormatter.timeZone = TimeZone(identifier: event.timezone)
        let formattedDate = displayFormatter.string(from: date)

        return BabyEventDisplayableInfo(
            eventType: event.type,
            eventDate: formattedDate
        )
    }

    private func fetchJournalData(request: JournalRequestModel) {
        displayableEvents = []
        Task {
            do {
                let fetchJournalResponse = try await journalService.fetchJournalByDate(request: request)
                babyEvents = fetchJournalResponse.results
                babyEvents.forEach { baby in
                    displayableEvents
                        .append(transforToDisplayableEvent(event: baby))
                }
                await MainActor.run {
                    state = .loaded(babiesNames, displayableEvents)
                }
            } catch {
                state = .error(error: error)
            }
        }
    }

    private func createJournalData(request: JournalCreateRequestProtocol) {
        Task {
            do{
                _ = try await journalService.createJournalEntry(
                    request: request
                )
                fetchBabies()
            } catch {
                await MainActor.run {
                    state = .error(error: error)
                }
            }
        }
    }

    private func formatDateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private func formatDateToISO8601UTCString(date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }

    private func mergeDatePickerWithCurrentTime(selectedDate: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: Date())

        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        combinedComponents.second = timeComponents.second
        combinedComponents.nanosecond = timeComponents.nanosecond

        return calendar.date(from: combinedComponents) ?? Date()
    }

    private func getStringEvent(event: EventType) -> String {
        switch event {
        case .sleep:
            return getSleepStatus()
        case .play:
            return getPlayStatus()
        default:
            return event.eventName
        }
    }

    private func getSleepStatus() -> String {
        let sleepState = userDefaults.getString(key: sleepStart)
        if sleepState == nil {
            userDefaults
                .set(
                    value: formatDateToISO8601UTCString(date: Date()),
                    key: sleepStart
                )
            return sleepStart
        } else {
            // TODO: here goes the logic to get the sleep time interval
            userDefaults.removeValue(key: sleepStart)
            return sleepEnd
        }
    }

    private func getPlayStatus() -> String {
        let playState = userDefaults.getString(key: playStart)
        if playState == nil {
            userDefaults
                .set(
                    value: formatDateToISO8601UTCString(date: Date()),
                    key: playStart
                )
            return playStart
        } else {
            // TODO: here goes the logic to get the play time interval
            userDefaults.removeValue(key: playStart)
            return playEnd
        }
    }

    // MARK: Public methods

    func createJournalFetchRequest(selectedBabyIndex: Int, selectedDate: Date) {
        currentBabyIndex = selectedBabyIndex
        currentDate = selectedDate
        let rangeKey = babies[selectedBabyIndex].account?.rangeKey
        if let rangeKey {
            let fetchRequest = JournalRequestModel(
                accountPartitionKey: "CincinnatiBabyService",
                accountRangeKey: rangeKey,
                userId: "",
                date: formatDateToString(date: selectedDate),
                lastRangeKey: ""
            )
            fetchJournalData(request: fetchRequest)
        }
    }

    func createJournalCreateRequest(
        event: EventType,
        selectedBabyIndex: Int,
        selectedDate: Date,
        requestBody: BabyEventBodyModel = BabyEventBodyModel()
    ){
        currentDate = selectedDate
        currentBabyIndex = selectedBabyIndex
        let stringEvent = getStringEvent(event: event)
        let baby = babies[selectedBabyIndex]
        let dateTime = mergeDatePickerWithCurrentTime(
            selectedDate: selectedDate
        )

        guard let accountRangeKey = baby.account?.rangeKey,
              let userId = baby.accountProfile?.rangeKey else {
            return
        }

        do {
            let bodyData = try JSONEncoder().encode(requestBody)
            let bodyString = String(data: bodyData, encoding: .utf8) ?? ""
            let createRequest = BabyJournalEventRequestModel(
                accountPartitionKey: "CincinnatiBabyService",
                accountRangeKey: accountRangeKey,
                body: bodyString,
                dayDate: formatDateToString(date: selectedDate),
                file: "",
                quantity: 0,
                timestamp: formatDateToISO8601UTCString(date: dateTime),
                type: stringEvent,
                unit: "",
                userId: userId
            )
            createJournalData(request: createRequest)
        } catch {
            state = .error(error: error)
        }
    }
}

struct BabyEventDisplayableInfo {
    public let eventType: String
    public let eventDate: String

    init(eventType: String, eventDate: String) {
        self.eventType = eventType
        self.eventDate = eventDate
    }
}
