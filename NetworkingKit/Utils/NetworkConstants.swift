//
//  NetworkConstants.swift
//  NetworkingKit
//
//  Created by Noel Hiram Pat Angulo on 7/9/25.
//

public enum NetworkConstants {
    public enum Request {
        public static let httpMethodGet = "GET"
        public static let httpMethodPost = "POST"
        public static let authorizationHeader = "Authorization"
        public static let contentType = "Content-Type"
        public static let applicationJson = "application/json"
    }

    public enum Endpoint {
        public static let fetchAccounts = "fetchAccounts"
    }

    public enum Error {
        public static let missingURL = "Missing or invalid URL"
        public static let buildRequest = "Build Request Error"
    }
}
