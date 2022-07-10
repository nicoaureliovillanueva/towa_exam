//
//  UserDetailsViewModel.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/6/22.
//

import Foundation
import RxRelay
import KeychainSwift

class UserDetailsViewModel {
    
    let keychain = KeychainSwift()
    
    var userDataRelay: BehaviorRelay<User?>
    
    init() {
        self.userDataRelay = .init(value: nil)
    }
    
    func clearUserData() {
        session.username.removeAll()
        session.appState = false
        keychain.clear()
    }
    
}
