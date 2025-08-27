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
        public static let create = "create"
        public static let update = "update"
        public static let delete = "delete"
    }

    public enum QueryItem {
        public static let action = "action"
        public static let partitionKey = "partitionKey"
        public static let rangeKey = "rangeKey"
        public static let cincinnatiBabyService = "CincinnatiBabyService"
    }

    public enum Error {
        public static let missingURL = "Missing or invalid URL"
        public static let buildRequest = "Build Request Error"
    }
}
