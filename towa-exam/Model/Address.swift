//
//  Address.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/6/22.
//

import Foundation

class Address: Codable {
    let street, suite, city, zipcode: String
    let geo: GeoLocation

    init(street: String, suite: String, city: String, zipcode: String, geo: GeoLocation) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}
