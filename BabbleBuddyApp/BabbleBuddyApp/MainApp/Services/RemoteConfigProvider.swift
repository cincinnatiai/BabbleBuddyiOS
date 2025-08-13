//
//  FirebaseService.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 5/1/25.
//

import Foundation
import FirebaseFirestore

// TODO: Create a protocol
class RemoteConfigProvider {

    private lazy var dataBase = Firestore.firestore()

    enum FirestoreServiceError: Error {
        case documentNotFound
        case unknownError(String)
    }

    func fetchBaseUrl() async throws -> String {
        do {
            let configuration = try await dataBase
                .collection("ios_configs")
                .document("configs")
                .getDocument()

            guard configuration.exists,
                  let data = configuration.data(),
                  let baseUrl = data["bfs_endpoint"] as? String,
                  !baseUrl.isEmpty else {
                throw FirestoreServiceError.documentNotFound
            }

            return baseUrl
        } catch {
            throw FirestoreServiceError.unknownError(error.localizedDescription)
        }
    }
}
