//
//  Company.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/6/22.
//

import Foundation

class Company: Codable {
    let name, catchPhrase, bs: String

    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
