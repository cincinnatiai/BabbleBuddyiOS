//
//  EndPointModel.swift
//  NetworkingKit
//
//  Created by Noel Hiram Pat Angulo on 7/9/25.
//

public struct EndPointModel {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data?

    public init(
        url: URL,
        method: HTTPMethod = .GET,
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }

    public enum HTTPMethod: String {
        case GET
        case POST
        case PATCH
    }
}
