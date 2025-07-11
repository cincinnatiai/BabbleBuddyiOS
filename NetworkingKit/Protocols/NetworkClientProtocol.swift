//
//  NetworkClientProtocol.swift
//  NetworkingKit
//
//  Created by Noel Hiram Pat Angulo on 7/9/25.
//

public protocol NetworkClientProtocol {
    func request<T: Decodable>(
        endpoint: EndPointModel,
        responseType: T.Type
    ) async throws -> T
}
