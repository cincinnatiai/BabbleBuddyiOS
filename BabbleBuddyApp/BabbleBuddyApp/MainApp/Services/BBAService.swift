import Foundation
import BabiesListAndRegistration
import NetworkingKit

class BBAServiceImplementation: BBAServiceProtocol {
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
                name: "action",
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

    func createBaby(request: CreateBabyRequestProtocol) async throws -> CreateBabyResponseProtocol {
            guard var components = URLComponents(string: baseURL) else {
                throw ServiceErrors.invalidURL
            }

            components.queryItems = [
                URLQueryItem(name: "action", value: "create")
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
}
