//
//  FirebaseService.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 4/10/25.
//

import Foundation
import FirebaseFirestore

class FirebaseService {
    
    private let db = Firestore.firestore()

    enum FirestoreServiceError: Error {
        case documentNotFound
        case unableToSaveConfig
        case unableToLoadConfig
        case unknownError(String)
    }
    
    func fetchURLs(completion: @escaping (Result<[String: Any], FirestoreServiceError>) -> Void) {
        db.collection("ios_configs")
          .document("configs")
          .getDocument { (document, error) in
            if let error = error {
              completion(.failure(.unknownError(error.localizedDescription)))
              return
            }
            guard let document = document, document.exists, let data = document.data() else {
              completion(.failure(.documentNotFound))
              return
            }
            completion(.success(data))
          }
      }
}
