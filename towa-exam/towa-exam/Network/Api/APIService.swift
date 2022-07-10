//
//  APIService.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/10/22.
//

import Foundation

import Alamofire
struct APIServices {
    
  public static let shared = APIServices()
  func getUser(parameters: Parameters? = nil, success: @escaping (_ result: [User?]) -> Void, failure: @escaping (_ failureMsg: FailureMessage) -> Void) {
    
      APIManager.shared.callAPI(serverURL: "https://jsonplaceholder.typicode.com/users",
                                method: .get,
                                headers: nil,
                                parameters: nil,
                                success: { response in
          do {
            if let data = response.data {
              let createLoginResponse = try JSONDecoder().decode([User].self, from: data)
              success(createLoginResponse)
            }
          } catch {
            failure(FailureMessage(error.localizedDescription))
          }
          
      }, failure: { error in
          failure(FailureMessage(error))
          
      })
  }
}
