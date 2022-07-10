//
//  LoginViewModel.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import Foundation
import KeychainSwift

class LoginViewModel {
    
    let keychain = KeychainSwift()
    
    init() {
        
    }
    
    func validateCompletedField(username: String, password: String)-> Bool {
        return username != "" && password != ""
    }
    
    func validateUserCrendential(username: String, password: String)-> Bool {
        return username == session.username && password == keychain.get("password")
    }
    
    func saveUserCredential(isRememberState: Bool) {
        session.appState = isRememberState
    }
    
}
