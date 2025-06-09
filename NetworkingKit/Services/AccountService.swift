import Foundation
import BabiesList

public protocol BabyAccountService {
    func fetchBabies() async -> Result<[AccountResponseModel], Error>
}

public class BabiesListServiceImplementation: BabyAccountService {
    public typealias TokenProvider = () -> String
    public typealias BaseURLProvider = () -> String

    private let decoder: JSONDecoder = JSONDecoder()
    private let session: URLSession = URLSession.shared
    private let tokenProvider: TokenProvider
    private let baseURLProvider: BaseURLProvider

    public init(
    baseURLProvider: @escaping BaseURLProvider,
    tokenProvider: @escaping TokenProvider
    ){
        self.baseURLProvider = baseURLProvider
        self.tokenProvider = tokenProvider
    }

    public func fetchBabies() async -> Result<[AccountResponseModel], Error> {
        do {
            let request = try buildRequest()
            let (data, response) = try await performRequest(request)
            return try decodeResponse(data, response)
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

    private func decodeResponse(_ data: Data, _ response: URLResponse) throws -> Result<[AccountResponseModel], Error> {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceErrors.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ErrorMapper.HTTPErrorHandler(httpResponse.statusCode)
        }
        do {
            let babies = try decoder.decode([AccountResponseModel].self, from: data)
            return .success(babies)
        } catch {
            return .failure(ServiceErrors.decodingError)
        }
    }

    private func buildRequest() throws -> URLRequest {
        let baseURL = baseURLProvider()
        let idToken = tokenProvider()

        guard !baseURL.isEmpty, !idToken.isEmpty else {
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
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: Constants.Request.authorizationHeader)
        return request
    }
}
