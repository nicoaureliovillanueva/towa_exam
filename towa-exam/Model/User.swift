//
//  User.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/6/22.
//

import Foundation

class User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
    
    init(id: Int, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }

       
}
