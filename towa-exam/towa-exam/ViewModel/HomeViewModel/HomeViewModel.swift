//
//  HomeViewModel.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import Foundation
import Alamofire
import RxRelay
import KeychainSwift


class HomeViewModel {
    
    let keychain = KeychainSwift()
    
    private var userListApi: APIServices
    
    public var userListRelay: BehaviorRelay<[User?]>
    
    init(apiService: APIServices) {
        self.userListRelay = .init(value: [])
        self.userListApi = apiService
    }
        
    func getUserList() {
        userListApi.getUser(parameters: nil) { response in
            self.userListRelay.accept(response)
        } failure: { errorMessage in
            print(errorMessage)
        }
    }
    
    
}
