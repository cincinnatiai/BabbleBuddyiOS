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

extension ServiceErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .invalidRequest:
            return "The request could not be created."
        case .missingAuthToken:
            return "Authorization token is missing."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .decodingError:
            return "Failed to decode the server response."
        case .networkError(let error):
            return error.localizedDescription
        case .httpError(let statusCode):
            return "Server returned an error with code \(statusCode)."
        case .badRequest:
            return "Bad request. Please try again."
        case .unauthorized:
            return "You are not authorized. Please log in again."
        case .forbidden:
            return "You don’t have permission to access this resource."
        case .notFound:
            return "The requested resource was not found."
        case .serverError:
            return "Internal server error. Please try again later."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
