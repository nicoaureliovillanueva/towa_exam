//
//  CLLocationCoordinate2D+Extension.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/9/22.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func distance(to:CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        
        return from.distance(from: to)
    }
}
