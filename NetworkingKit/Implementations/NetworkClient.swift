//
//  NetworkClient.swift
//  NetworkingKit
//
//  Created by Noel Hiram Pat Angulo on 7/9/25.
//

public class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let token: String
    
    public init(session: URLSession = .shared, token: String) {
        self.session = session
        self.token = token
    }
    
    public func request<T: Decodable>(
        endpoint: EndPointModel,
        responseType: T.Type
    ) async throws -> T {
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body
        
        var allHeaders = endpoint.headers
        allHeaders[NetworkConstants.Request.authorizationHeader] = "Bearer \(token)"
        urlRequest.allHTTPHeaderFields = allHeaders
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceErrors.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ServiceErrors.unknown(
                NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil)
            )
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ServiceErrors.decodingError
        }
    }
}
