import Foundation

public enum ServiceErrors: Error {
    case invalidURL
    case invalidRequest
    case missingAuthToken
    case invalidResponse
    case decodingError
    case networkError(URLError)
    case httpError(Int)
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknown(Error)
}

public enum ServiceErrorCode {
    static let missingAuthData = -1
}
