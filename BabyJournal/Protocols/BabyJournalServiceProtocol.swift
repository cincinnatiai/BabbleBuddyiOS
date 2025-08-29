//
//  BabyJournalProtocol.swift
//  BabyJournal
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

public protocol BabyJournalServiceProtocol {
    func fetchJournalByDate(request: FetchJournalByDateRequestProtocol) async throws -> BabyJournalEventResponseProtocol

    func createJournalEntry(request: JournalCreateRequestProtocol) async throws -> JournalCreateResponseProtocol

    func deleteJournalEntry(request: JournalDeleteRequestProtocol) async throws -> Bool
}
