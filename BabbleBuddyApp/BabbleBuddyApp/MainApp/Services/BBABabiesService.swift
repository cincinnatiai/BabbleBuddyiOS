import Foundation
import BabiesListAndRegistration
import NetworkingKit

class BBABabiesServiceImplementation: BBABabiesServiceProtocol {
    private let client: NetworkClientProtocol
    private let baseURL: String

    init(client: NetworkClient, baseURL: String) {
        self.client = client
        self.baseURL = baseURL
    }

    func fetchBabies() async throws -> [BabiesResponseProtocol] {
        guard var components = URLComponents(string: baseURL) else {
            throw ServiceErrors.invalidURL
        }

        components.queryItems = [
            URLQueryItem(
                name: NetworkConstants.QueryItem.action,
                value: NetworkConstants.Endpoint.fetchAccounts
            )
        ]

        guard let url = components.url else {
            throw ServiceErrors.invalidURL
        }

        let endpoint = EndPointModel(
            url: url,
            method: .POST,
            headers: [:],
            body: nil
        )

        return try await client.request(endpoint: endpoint, responseType: [BabiesResponseModel].self)
    }

    func fetchBaby(with key: String) async throws -> CreateBabyResponseProtocol {
        guard var componets = URLComponents(string: baseURL) else {
            throw ServiceErrors.invalidURL
        }

        componets.queryItems = [
            URLQueryItem(
                name: NetworkConstants.QueryItem.partitionKey,
                value: NetworkConstants.QueryItem.cincinnatiBabyService
            ),
            URLQueryItem(
                name: NetworkConstants.QueryItem.rangeKey,
                value: key
            )
        ]

        guard let url = componets.url else {
            throw ServiceErrors.invalidURL
        }

        let endpoint = EndPointModel(
            url: url,
            method: .GET,
            headers: [:],
            body: nil
        )

        return try await client.request(endpoint: endpoint, responseType: CreateBabyResponseModel.self)
    }

    func createBaby(request: CreateBabyRequestProtocol) async throws -> CreateBabyResponseProtocol {
        guard var components = URLComponents(string: baseURL) else {
            throw ServiceErrors.invalidURL
        }

        components.queryItems = [
            URLQueryItem(
                name: NetworkConstants.QueryItem.action,
                value: NetworkConstants.Endpoint.create
            )
        ]

        guard let url = components.url else {
            throw ServiceErrors.invalidURL
        }

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
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
                responseType: CreateBabyResponseModel.self
            )

        return response as CreateBabyResponseProtocol
    }

    func editBaby(request: EditBabyRequestProtocol) async throws -> Bool {
        guard var components = URLComponents(string: baseURL) else {
            throw ServiceErrors.invalidURL
        }

        components.queryItems = [
            URLQueryItem(
                name: NetworkConstants.QueryItem.action,
                value: NetworkConstants.Endpoint.update
            )
        ]

        guard let url = components.url else {
            throw ServiceErrors.invalidURL
        }

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let body = try encoder.encode(request)

        let endpoint = EndPointModel(
            url: url,
            method: .POST,
            headers: [:],
            body: body
        )

        let success = try await client
            .request(
                endpoint: endpoint,
                responseType: Bool.self
            )
        return success
    }

    func deleteBaby(request: DeleteBabyRequestProtocol) async throws -> Bool {
        guard var components = URLComponents(string: baseURL) else {
            throw ServiceErrors.invalidURL
        }

        components.queryItems = [
            URLQueryItem(
                name: NetworkConstants.QueryItem.action,
                value: NetworkConstants.Endpoint.delete
            )
        ]

        guard let url = components.url else {
            throw ServiceErrors.invalidURL
        }

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let body = try encoder.encode(request)

        let endpoint = EndPointModel(
            url: url,
            method: .POST,
            headers: [:],
            body: body
        )

        let success = try await client
            .request(
                endpoint: endpoint,
                responseType: Bool.self
            )
        return success
    }
}
