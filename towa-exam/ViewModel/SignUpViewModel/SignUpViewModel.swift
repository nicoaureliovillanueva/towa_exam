//
//  SignUpViewModel.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import Foundation
import KeychainSwift
import RxRelay

class SignUpViewModel {
    
    let keychain = KeychainSwift()
    
    var isUserNameInvalid: BehaviorRelay<Bool>
    var isPasswordInvalid: BehaviorRelay<Bool>
    
    
    init() {
        self.isUserNameInvalid = .init(value: true)
        self.isPasswordInvalid = .init(value: true)
    }
    
    func isCanProceed(username: String, password: String)-> Bool {
        return username != "" && password != ""
    }
    
    func saveUserCredential(username: String?, password: String?) {
        
        /** Save user credential to Local storage. UserDefaults and Keychain  **/
        
        guard let userName = username else { return }
        session.username = userName
        
        session.appState = false
        
        guard let password = password else { return }
        keychain.set(password, forKey: "password")
    }
    
    func validateRegisteredUser(username: String?)-> Bool {
        return username == session.username
    }
    
    func usernameValidationMessage(characterCount: Int)-> String {
        /** Username must at least 3 characters  **/
        isUserNameInvalid.accept(characterCount < 3)
        return characterCount < 3 ? R.string.localizable.username_validation_error_message() : ""
    }
    
    func passwordValidateMessage(password: String)-> String {
        
        /** Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number: **/
        
        let regex = "^(?=.{8,}$)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).*$"
        let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: password)
        
        isPasswordInvalid.accept(!isMatched)
        return !isMatched ? R.string.localizable.password_validation_error_message() : ""
        
    }
    
    func isValidCredentials()-> Bool {
        return isUserNameInvalid.value && isPasswordInvalid.value
    }
    
}
