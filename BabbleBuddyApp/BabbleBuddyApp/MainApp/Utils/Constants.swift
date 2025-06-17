import Foundation

public struct Constants {
    public struct Request {
        public static let httpMethod = "POST"
        public static let authorizationHeader = "Authorization"
        public static let authType = "Bearer"
    }
    public struct Endpoint {
        public static let fetchAccounts = "fetchAccounts"
    }

    public struct Error {
        public static let buildRequest = "BuildRequest"
        public static let missingURL = "Missing baseURL or idToken"

    }
}
