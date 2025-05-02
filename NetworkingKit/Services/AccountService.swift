import Foundation
import BabiesList

public protocol BabiesListService {
    func fetchBabies() async -> Result<[AccountResponseModel], Error>
}

public class BabiesListServiceImplementation: BabiesListService {
    public typealias AuthDataProvider = () -> (baseURL: String, idToken: String)

    private let decoder: JSONDecoder = JSONDecoder()
    private let session: URLSession = URLSession.shared
    private let authDataProvider: AuthDataProvider

    public init(dataProvider: @escaping AuthDataProvider) {
        self.authDataProvider = dataProvider
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
            throw mapHTTPError(httpResponse.statusCode)
        }
        do {
            let babies = try decoder.decode([AccountResponseModel].self, from: data)
            return .success(babies)
        } catch {
            return .failure(ServiceErrors.decodingError)
        }
    }

    private func buildRequest() throws -> URLRequest {

        let (baseURL, idToken) = authDataProvider()

        guard !baseURL.isEmpty, !idToken.isEmpty else {
            throw ServiceErrors.unknown(
                NSError(domain: Constants.buildRequest, code: ServiceErrorCode.missingAuthData, userInfo: [
                    NSLocalizedDescriptionKey: Constants.missingURL
                ])
            )
        }

        guard let url = URL(string: baseURL + Constants.babiesListEndpoint ) else { throw ServiceErrors.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = Constants.postMethod
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: Constants.authorizationHeader)
        return request
    }

    private func mapHTTPError(_ statusCode: Int) -> ServiceErrors {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 500: return .serverError
        default: return .httpError(statusCode)
        }
    }
}
