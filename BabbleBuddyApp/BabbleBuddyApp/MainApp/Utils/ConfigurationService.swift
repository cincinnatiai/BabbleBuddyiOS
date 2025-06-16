import Foundation
import CoreKit

protocol ConfigurationServiceProtocol {
    func fetchBaseURL(completion: @escaping (Result<String, Error>) -> Void)
}

final class ConfigurationService: ConfigurationServiceProtocol {
    private let remoteConfigProvider: RemoteConfigProvider

    init(remoteConfigProvider: RemoteConfigProvider) {
        self.remoteConfigProvider = remoteConfigProvider
    }

    func fetchBaseURL(completion: @escaping (Result<String, Error>) -> Void) {
        remoteConfigProvider.fetchURLs { result in
            switch result {
            case .success(let config):
                if let url = config["bfs_endpoint"] as? String {
                    KeychainHelper.shared.save(url, forKey: "baseURL")
                    completion(.success(url))
                } else {
                    completion(.failure(NSError(domain: "MissingURL", code: -1)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
