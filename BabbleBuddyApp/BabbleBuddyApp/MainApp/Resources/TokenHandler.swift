//
//  TokenHandler.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 5/1/25.
//

import Foundation
import AuthLibrarySPM

class TokenHandler: TokenManagerProtocol {
    
    var onTokenSaved: (() -> Void)?
    
    func manageTokenId(idToken: String) {
        KeychainHelper.shared.save(idToken, forKey: BabbleBuddyAppResources.KeychainKeys.idToken.rawValue)
        onTokenSaved?()
    }
}
