//
//  GeoLocation.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/6/22.
//

import Foundation

class GeoLocation: Codable {
    let lat, lng: String

    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}
