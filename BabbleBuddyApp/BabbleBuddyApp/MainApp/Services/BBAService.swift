import Foundation
import BabiesListAndRegistration

public class BBAServiceImplementation: BBAServiceProtocol {
    private let decoder: JSONDecoder = JSONDecoder()
    private let session: URLSession = URLSession.shared
    private let token: String
    private let baseURL: String

    public init(baseURL: String, token: String) {
        self.baseURL = baseURL
        self.token = token
    }

    public func fetchBabies() async -> Result<[BabiesResponseProtocol], Error> {
        do {
            let request = try buildRequest()
            let (data, response) = try await performRequest(request)
            return try decodeResponse(data, response)
                .map { $0 as [any BabiesResponseProtocol] }
        } catch {
            return .failure(error)
        }
    }

    private func performRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch let urlError as URLError {
            throw ServiceErrors.networkError(urlError)
        }
    }

    private func decodeResponse(_ data: Data, _ response: URLResponse) throws -> Result<[BabiesResponseModel], Error> {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceErrors.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ErrorMapper.HTTPErrorHandler(httpResponse.statusCode)
        }
        do {
            let babies = try decoder.decode([BabiesResponseModel].self, from: data)
            return .success(babies)
        } catch {
            return .failure(ServiceErrors.decodingError)
        }
    }

    private func buildRequest() throws -> URLRequest {
        guard !baseURL.isEmpty, !token.isEmpty else {
            throw ServiceErrors.unknown(
                NSError(domain: Constants.Error.buildRequest, code: ServiceErrorCode.missingAuthData, userInfo: [
                    NSLocalizedDescriptionKey: Constants.Error.missingURL
                ])
            )
        }

        guard var components = URLComponents(string: baseURL) else {
            throw ServiceErrors.invalidURL
        }

        components.queryItems = [
            URLQueryItem(name: "action", value: Constants.Endpoint.fetchAccounts)
        ]

        guard let requestURL = components.url else {
            throw ServiceErrors.invalidURL
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = Constants.Request.httpMethod
        request.setValue("Bearer \(token)", forHTTPHeaderField: Constants.Request.authorizationHeader)
        return request
    }

    public func createBaby(request: CreateBabyRequestProtocol) async throws -> Bool {
        // TODO: Implement the call
        return true
    }
}
