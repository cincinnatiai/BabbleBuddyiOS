//
//  BabiesListService.swift
//  NetworkingKit
//
//  Created by Trainee on 4/11/25.
//

import Foundation
import BabiesList

public protocol BabiesListService {
    func fetchBabies() async -> Result<[AccountResponseModel],Error>
}

private struct Constants {
    static let babiesListEndpoint = "?action=fetchAccounts"
}

public class BabiesListServiceImpl: BabiesListService {
    private let decoder: JSONDecoder = JSONDecoder()
    private let session: URLSession = URLSession.shared
    private var receivedData: () -> (String,String)
    
    public init (dataProvider: @escaping () -> (String, String)) {
        self.receivedData = dataProvider
    }
    
    public func fetchBabies() async -> Result<[AccountResponseModel],Error> {
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
    
    private func decodeResponse(_ data: Data, _ response: URLResponse) throws -> Result<[AccountResponseModel],Error> {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceErrors.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw mapHTTPError(httpResponse.statusCode)
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let babies = try decoder.decode([AccountResponseModel].self, from: data)
            return .success(babies)
        } catch {
            return .failure(ServiceErrors.decodingError)
        }
    }
    
    
    private func buildRequest() throws -> URLRequest {
        let data = receivedData()
        let baseUrl = data.0
        guard let url = URL(string: baseUrl + Constants.babiesListEndpoint ) else { throw ServiceErrors.invalidUrl }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(data.1)", forHTTPHeaderField: "Authorization")
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

enum ServiceErrors: Error {
    case invalidUrl
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
