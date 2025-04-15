//
//  TokenHandler.swift
//  BabbleBuddyApp
//
//  Created by Trainee on 4/10/25.
//

import Foundation
import AuthLibrarySPM

class TokenHandler: TokenManagerProtocol {
    
    var onTokenSaved: (() -> Void)?
    func manageTokenId(idToken: String) {
        KeychainHelper.shared.saveValue(idToken, for: .idToken)
        onTokenSaved?()
    }
}
