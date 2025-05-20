import Foundation

public enum ErrorMapper {
    public static func HTTPErrorHandler(_ statusCode: Int) -> ServiceErrors {
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
