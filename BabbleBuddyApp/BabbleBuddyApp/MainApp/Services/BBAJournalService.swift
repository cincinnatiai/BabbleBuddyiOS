//
//  BBAJournalService.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 7/10/25.
//

import BabyJournal
import NetworkingKit

class BBAJournalService: BabyJournalServiceProtocol {
    private let client: NetworkClientProtocol
    private let baseURL: String

    init(client: NetworkClient, baseURL: String) {
        self.client = client
        self.baseURL = baseURL
    }

    func fetchJournalByDate(request: any FetchJournalByDateRequestProtocol) async throws -> any BabyJournalEventResponseProtocol {
        guard var components = URLComponents(string: baseURL) else {
            throw ServiceErrors.invalidURL
        }

        components.queryItems = [
            URLQueryItem(name: "controller", value: "babyEvent"),
            URLQueryItem(name: "action", value: "fetchByDate")
        ]

        guard let url = components.url else {
            throw ServiceErrors.invalidURL
        }

        let encoder = JSONEncoder()
        let body = try encoder.encode(request)

        let endpoint = EndPointModel(
            url: url,
            method: .POST,
            headers: [:],
            body: body
        )

        let response = try await client
            .request(
                endpoint: endpoint,
                responseType: BabyJournalEventResponseModel.self
            )

        return response
    }

    func createJournalEntry(request: JournalCreateRequestProtocol) async throws -> JournalCreateResponseProtocol {
        guard var components = URLComponents(string: baseURL) else {
            throw ServiceErrors.invalidURL
        }

        components.queryItems = [
            URLQueryItem(name: "controller", value: "babyEvent"),
            URLQueryItem(name: "action", value: "create")
        ]

        guard let url = components.url else {
            throw ServiceErrors.invalidURL
        }

        let encoder = JSONEncoder()
        let body = try encoder.encode(request)

        let endpoint = EndPointModel(
            url: url,
            method: .POST,
            headers: [:],
            body: body
        )

        let response = try await client
            .request(
                endpoint: endpoint,
                responseType: BabyEventModel.self
            )

        return response
    }
}
