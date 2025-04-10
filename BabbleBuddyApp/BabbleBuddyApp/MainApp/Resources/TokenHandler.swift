//
//  TokenHandler.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 4/10/25.
//

import Foundation
import AuthLibrarySPM

class TokenHandler: TokenManagerProtocol {
    
    func manageTokenId(idToken: String) {
        KeychainHelper.shared.save(idToken, forKey: "idToken")
    }
}
